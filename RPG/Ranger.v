`timescale 1ns / 1ps

module Ranger(
	input clk,
	input [2:0] rangerNum,
	input [3:0] inputs,
	output [19:0] position
    );
	 
	 
//        parameter UP_BOUND = 31;    
//        parameter DOWN_BOUND = 510;    
//        parameter LEFT_BOUND = 144;    
//        parameter RIGHT_BOUND = 783; 

	//Enemy initial positions here
	//Ranger 1
	reg [9:0] a_hpos1 = 368;
   reg [9:0] a_vpos1 = 127; 

	//Ranger 2
	reg [9:0] a_hpos2 = 656;
   reg [9:0] a_vpos2 = 127;
	
	//Ranger 3
	reg [9:0] a_hpos3 = 624;
   reg [9:0] a_vpos3 = 329;
	
	//Ranger 4
	reg [9:0] a_hpos4 = 240;
   reg [9:0] a_vpos4 = 447;
	
	//Ranger 5
	reg [9:0] a_hpos5 = 368;
   reg [9:0] a_vpos5 = 240;
 
	
	assign position = {a_hpos,a_vpos};
	
	always@(posedge clk) begin
		case(inputs)
			4'b1000: a_vpos <= a_vpos;// - 3'd5; // up
			4'b0100: a_vpos <= a_vpos;// + 3'd5; // down
			4'b0010: a_hpos <= a_hpos;// - 3'd5; //left
			4'b0001: a_hpos <= a_hpos;// + 3'd5; //right
		endcase
	end
endmodule
