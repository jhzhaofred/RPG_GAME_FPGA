`timescale 1ns / 1ps    
        
    module vga_controller(    
        input clk,   
		  input keyclk,		  
		  input keyinput,
        input rst,
		  input left,right,up,down,
        output reg [2:0] r,    
        output reg [2:0] g,    
        output reg [1:0] b,
		  output [7:0] led,
        output hs,    
        output vs    
        );    
        
//        parameter UP_BOUND = 31;    
//        parameter DOWN_BOUND = 510;    
//        parameter LEFT_BOUND = 144;    
//        parameter RIGHT_BOUND = 783;   
		  wire [7:0] keyVal;
		  wire [2:0] red, green;
		  wire [1:0] blue;
		  wire [19:0] position, e_position;
        wire pclk;
		  reg [1:0] step = 0;		  
        reg [1:0] count;		  
        reg [9:0] hcount, vcount, a_hpos, a_vpos, e_hpos, e_vpos;
        reg [9:0] house_hpos = 624; 
		  reg [9:0] house_vpos = 81;  	  
		  wire clk_1s;
		  wire [8:0] voffset, hoffset, e_voffset, e_hoffset;
        assign pclk = count[1];
		  wire [7:0] AshData, EnemyData, HouseData;
		  wire display_ash, display_enemy, display_house;
		  reg [15:0] ranger_count = 0;
		  reg [3:0] rangering = 0;
		  
		  wire kleft,kright,kup,kdown;
		  
		  assign display_ash = (hcount - a_hpos <= 16 && hcount - a_hpos > 0 && vcount - a_vpos >= 0 && vcount - a_vpos < 16);
		  assign display_enemy = (hcount - e_hpos <= 16 && hcount - e_hpos > 0 && vcount - e_vpos >= 0 && vcount - e_vpos < 16);
		  assign display_house = (hcount - house_hpos <= 64 && hcount - house_hpos > 0 && vcount - house_vpos >= 0 && vcount - house_vpos < 48);
		  assign vs = (vcount < 2) ? 0 : 1;    
		  assign kleft = led == 8'h6b ? 1 : left;
		  assign kright = led == 8'h74 ? 1 : right;
		  assign kup = led == 8'h75 ? 1 : up;
		  assign kdown = led == 8'h72 ? 1 : down;
		  clk_div_1s clk_d(clk, clk_1s);
		  
		  Keyboard_PS2 keyboard(clk, 1, keyclk, keyinput, led);
		  Ash ash(
			  .clka(pclk), // input clka
			  .addra((((vcount - a_vpos)%16 + voffset) * 48 + (hcount - a_hpos + hoffset)) * 1), // input [31 : 0] addra
			  .douta(AshData) // output [31 : 0] AshData
			);

		  Enemy rocket(
			  .clka(pclk), // input clka
			  .addra((((vcount - e_vpos)%16 + e_voffset) * 48 + (hcount - e_hpos + e_hoffset)) * 1), // input [31 : 0] addra
			  .douta(EnemyData) // output [31 : 0] AshData
			);
			
		  house h0 (
			  .clka(pclk), // input clka
			  .addra((vcount - house_vpos) * 64 + hcount - house_hpos), // input [11 : 0] addra
			  .douta(HouseData) // output [7 : 0] douta
			);
		
		  Background Dis(pclk, clk_1s, hcount, vcount, {red,green,blue});
		  Sprite_Sel SEL0(pclk, {kup,kdown,kleft,kright}, step, hoffset, voffset);
		  Sprite_Sel SEL1(pclk, rangering, step, e_hoffset, e_voffset);
		  Move_Module m0(clk_1s, {kup,kdown,kleft,kright}, position);
        
		  Ranger r0(clk_1s, rangering, e_position);
		  
		  always @ (posedge clk)    
        begin    
            if (rst)     
                count <= 0;    
            else    
                count <= count+1;    
        end    
		        
        assign hs = (hcount < 96) ? 0 : 1;    
        always @ (posedge pclk or posedge rst)    
        begin    
            if (rst)    
                hcount <= 0;    
            else if (hcount == 799)    
                hcount <= 0;    
            else    
                hcount <= hcount+1;    
        end    
        
        always @ (posedge pclk or posedge rst)    
        begin    
            if (rst)    
                vcount <= 0;    
            else if (hcount == 799) begin    
                if (vcount == 520)    
                    vcount <= 0;    
                else    
                    vcount <= vcount+1;    
            end    
            else    
                vcount <= vcount;    
        end   
		  
		  
        always @ (posedge pclk)    
        begin
		  		r <= display_ash == 1 ? AshData == 8'b11111111 ? red : AshData[7:5] : 
					  display_enemy == 1 ? EnemyData == 8'b11111111 ? red : EnemyData[7:5] : 
					  display_house == 1 ? HouseData == 8'b11111111 ? red : HouseData[7:5] : red;
				g <= display_ash == 1 ? AshData == 8'b11111111 ? green : AshData[4:2] : 
					  display_enemy == 1 ? EnemyData == 8'b11111111 ? green: EnemyData[4:2] : 
					  display_house == 1 ? HouseData == 8'b11111111 ? green : HouseData[4:2] : green;
				b <= display_ash == 1 ? AshData == 8'b11111111 ? blue : AshData[1:0] : 
					  display_enemy == 1 ? EnemyData == 8'b11111111 ? blue: EnemyData[1:0] : 
					  display_house == 1 ?HouseData == 8'b11111111 ? blue : HouseData[1:0] : blue;
		  end
		  
		  always@(position) begin
				a_hpos <= position[19:10];
				a_vpos <= position[9:0];
				{e_hpos, e_vpos} <= e_position;
		  end

		  always@(posedge clk_1s) begin
				step = step + 1;
		  end
		  
		  always@(posedge clk_1s) begin
				ranger_count <= ranger_count + 1 == 60 ? 0 : ranger_count + 1;
				case(ranger_count)
				0:rangering = 4'b0001;
				10:rangering = 4'b0000;
				20:rangering = 4'b0010;
				30:rangering = 4'b0100;
				40:rangering = 4'b0000;
				50:rangering = 4'b1000;
				endcase
		  end
    endmodule    