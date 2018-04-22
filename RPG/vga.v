`timescale 1ns / 1ps    
        
    module vga_controller(    
        input clk,   
		  input keyclk,		  
		  input keyinput,
        input rst,
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
		  
		  //VGA wires, position registers
		  wire [2:0] red, green;
		  wire [1:0] blue;
		  reg [9:0] hcount, vcount; 
		  reg [9:0] a_hpos, a_vpos, e_hpos, e_vpos;
		  
		  wire pclk;
		  assign pclk = count[1];
		  wire [8:0] voffset, hoffset, e_voffset, e_hoffset;
        
		  assign vs = (vcount < 2) ? 1'b0 : 1'b1;
		  
		  //House Position
		  reg [9:0] house_hpos = 624; 
		  reg [9:0] house_vpos = 81;
		  
		  reg [1:0] step = 0;		  
        reg [1:0] count;		  
        
		  wire clk_1s;
		  
		  //Sprite Select Wires and Memory Modules
		  wire display_ash, display_enemy, display_house;
		  wire [7:0] AshData, EnemyData, HouseData;
		  reg [15:0] ranger_count = 0;
		  reg [3:0] rangering = 0;
		  
		  Ash ash(
			  .clka(pclk), // input clka
			  .addra((((vcount - a_vpos) % 16 + voffset) * 48 + (hcount - a_hpos + hoffset)) * 1), // input [31 : 0] addra
			  .douta(AshData) // output [31 : 0] AshData
			);

		  Enemy rocket(
			  .clka(pclk), // input clka
			  .addra((((vcount - e_vpos) % 16 + e_voffset) * 48 + (hcount - e_hpos + e_hoffset)) * 1), // input [31 : 0] addra
			  .douta(EnemyData) // output [31 : 0] AshData
			);
			
		  //Direction Control from Keyboard
		  Keyboard_PS2 					keyboard(clk, 1, keyclk, keyinput, led);
		  
		  wire kleft, kright, kup, kdown;
		  assign kleft = led == 8'h6b ? 1'b1 : 1'b0;
		  assign kright = led == 8'h74 ? 1'b1 : 1'b0;
		  assign kup = led == 8'h75 ? 1'b1 : 1'b0;
		  assign kdown = led == 8'h72 ? 1'b1 : 1'b0;
		  
		  //Player and enemy position
		  wire [19:0] position, e_position, e_position2, e_position3, e_position4;
		  
		  //Sprite Display Control
		  assign display_ash = (hcount - a_hpos <= 16 && hcount - a_hpos > 0 && vcount - a_vpos >= 0 && vcount - a_vpos < 16);
		  assign display_enemy = (hcount - e_hpos <= 16 && hcount - e_hpos > 0 && vcount - e_vpos >= 0 && vcount - e_vpos < 16);
		  assign display_house = 1'b0;	//(hcount - house_hpos <= 64 && hcount - house_hpos > 0 && vcount - house_vpos >= 0 && vcount - house_vpos < 48);
		      
		  //1 Second Clock
		  clk_div_1s 						clk_d(clk, clk_1s);
		  
		  
		  //Collision Detection
		  
		  reg [0:299] collisionMatrix = 300'b101111111111111111111000000000001000000111111111111010101101100000100010101001011010101110101010010110101000001000100101101011111111111101011010000010001000010110111110101010100101101000001010001001011010111110101111010110100010001010000101101110111111101011011000100000000010000111111111111111111101;
		  /*
			Collision Matrix but Easier to See:
			20 x 15, multiply by 32 to fill screen
			
			10111111111111111111
			10000000000010000001
			11111111111010101101
			10000010001010100101
			10101011101010100101
			10101000001000100101
			10101111111111110101
			10100000100010000101
			10111110101010100101
			10100000101000100101
			10101111101011110101
			10100010001010000101
			10111011111110101101
			10001000000000100001
			11111111111111111101
		  */

		  wire [19:0] newPosition;
		  wire enemyCollide;
		
		  //Move Player Module
		  Move_Module m0(e_position, clk_1s, {kup,kdown,kleft,kright}, enemyCollide, newPosition);
		  Ranger r0(clk_1s, 3'b001, rangering, e_position);
		  
		   //Update Player and Enemy Position
		  always@(posedge clk) begin
				{a_hpos, a_vpos} <= newPosition;
				{e_hpos, e_vpos} <= e_position;
		  end
		  
		  //Display Select
		  Background Dis(pclk, clk_1s, hcount, vcount, {red,green,blue});
		  Sprite_Sel SEL0(pclk, {kup,kdown,kleft,kright}, step, hoffset, voffset);
		  Sprite_Sel SEL1(pclk, rangering, step, e_hoffset, e_voffset);
		  
		  //Reset
		  always @ (posedge clk)    
        begin    
            if (rst)     
                count <= 1'b0;    
            else    
                count <= count + 1'b1;    
        end    
		   
		  //Horizontal VGA
        assign hs = (hcount < 96) ? 1'b0 : 1'b1;    
        always @ (posedge pclk or posedge rst)    
        begin    
            if (rst)    
                hcount <= 0;    
            else if (hcount == 799)    
                hcount <= 0;    
            else    
                hcount <= hcount + 1'b1;    
        end  
		  
        //Vertical VGA
        always @ (posedge pclk or posedge rst)    
        begin    
            if (rst)    
                vcount <= 0;    
            else if (hcount == 799) begin    
                if (vcount == 520)    
                    vcount <= 0;    
                else    
                    vcount <= vcount + 1'b1;    
            end    
            else    
                vcount <= vcount;    
        end   
		  
		  //Maze VGA control signals
		  reg [4:0] mazeHorizontalCount = 5'd0; 
		  reg [4:0] mazeVerticalCount = 5'd0;
		  reg [4:0] matrixXLoc = 5'd0;
		  reg [3:0] matrixYLoc = 4'd0;
		  
		  //VGA Color Select
        always @ (posedge pclk)    
        begin
				//Display Maze
				if(collisionMatrix[matrixYLoc * 20 + matrixXLoc]) begin
					if(mazeHorizontalCount != 5'b11111) begin
						r <= 3'b111;
						g <= 3'b000;
						b <= 2'b11;
						
						mazeHorizontalCount <= mazeHorizontalCount + 1'b1;
					end
					
					else begin
						matrixXLoc = matrixXLoc + 1'b1;
						mazeHorizontalCount <= 1'b0;
					end
				
				end
				
				//If we want to display Ash
				else if(display_ash) begin
					if(AshData == 8'b11111111) begin
						r <= red;
						g <= green;
						b <= blue;
					end
					
					else begin
						r <= AshData[7:5];
						g <= AshData[4:2];
						b <= AshData[1:0];
					end
				end
				//If we want to display the enemy
				else if(display_enemy) begin
					if(EnemyData == 8'b11111111) begin
						r <= red;
						g <= green;
						b <= blue;
					end
					
					else begin
						r <= EnemyData[7:5];
						g <= EnemyData[4:2];
						b <= EnemyData[1:0];
					end
				end
				
				
				
				else begin
					r <= red;
					g <= green;
					b <= blue;
				end
		  end
		  
		  //Increase Steps
		  always@(posedge clk_1s) begin
				step = step + 1'b1;
		  end
		  
		  //Enemy Module
//		  always@(posedge clk_1s) begin
//				ranger_count <= ranger_count + 1'b1 == 60 ? 0 : ranger_count + 1'b1;
//				case(ranger_count)
//				0:rangering = 4'b0001;
//				10:rangering = 4'b0000;
//				20:rangering = 4'b0010;
//				30:rangering = 4'b0100;
//				40:rangering = 4'b0000;
//				50:rangering = 4'b1000;
//				endcase
//		  end
    endmodule    