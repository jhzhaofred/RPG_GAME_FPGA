  
`timescale 1ns / 1ps    
        
 module battle_screen(    
	  input clk,    
	  input rst,
	  input [6:0] switch,
	  output reg [2:0] r,    
	  output reg [2:0] g,    
	  output reg [1:0] b,    
	  output hs,    
	  output vs    
	  );    
	  
//	  parameter UP_BOUND = 31;    
//	  parameter DOWN_BOUND = 510;    
//	  parameter LEFT_BOUND = 144;    
//	  parameter RIGHT_BOUND = 783;    

	  wire pclk;    
	  reg [1:0] count;		  
	  reg [9:0] hcount, vcount;    
	  reg [9:0] hp_xpos = 200;
	  reg [9:0] hp_ypos = 400;
	  
	  assign pclk = count[1];    
	  wire [7:0] grass, douta;
		
	  Grass grass0 (
		  .clka(pclk), // input clka
		  .addra((vcount%8) * 8 + hcount%8), // input [5 : 0] addra
		  .douta(grass) // output [7 : 0] douta
		);
		BattleThing your_instance_name (
		  .clka(pclk), // input clka
		  .addra(((vcount - hp_ypos)%48) * 32 + (hcount - hp_xpos)%32), // input [10 : 0] addra
		  .douta(douta) // output [7 : 0] douta
		);
	  always @ (posedge clk)    
	  begin    
			if (rst)    
				 count <= 0;    
			else    
				 count <= count + 1'b1;    
	  end    
			
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

	  assign vs = (vcount < 2) ? 1'b0 : 1'b1;    
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
			

	  always @ (posedge pclk or posedge rst)    
	  begin    
			if (rst) begin    
				 r <= 3'b000;    
				 g <= 3'b000;    
				 b <= 2'b00;    
			end    
			else begin    
				 if (vcount>=31 && vcount<=510    
							&& hcount>=144 && hcount<=783) begin 
						if (vcount>=400 && vcount<=448    
							&& hcount>=200 && hcount<=232) begin 
							  r <= douta[7:5];    
							  g <= douta[4:2];    
							  b <= douta[1:0];
						end 
						else begin
							  r <= grass[7:5];    
							  g <= grass[4:2];    
							  b <= grass[1:0];
						end
				 end    
				 else begin    
					  r <= 3'b000;    
					  g <= 3'b000;    
					  b <= 2'b00;    
				 end    
			end    
	  end    
 
	  
 endmodule    
