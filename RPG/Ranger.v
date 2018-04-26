`timescale 1ns / 1ps

module Ranger(
	input clk,
	input [2:0] rangerNum,
	input [3:0] inputs,
	output reg [19:0] position
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
	reg [9:0] a_hpos2 = 672;
   reg [9:0] a_vpos2 = 127;
	
	//Ranger 3
	reg [9:0] a_hpos3 = 624;
   reg [9:0] a_vpos3 = 329;
	
	//Ranger 4
	reg [9:0] a_hpos4 = 256;
   reg [9:0] a_vpos4 = 447;
	
	//Ranger 5
	reg [9:0] a_hpos5 = 368;
   reg [9:0] a_vpos5 = 383;
	
	always@(posedge clk) begin
		case(rangerNum)
			3'b001: position <= {a_hpos1,a_vpos1};
			3'b010: position <= {a_hpos2,a_vpos2};
			3'b011: position <= {a_hpos3,a_vpos3};
			3'b100: position <= {a_hpos4,a_vpos4};
			3'b101: position <= {a_hpos5,a_vpos5};
			default: position <= 19'd0;
		endcase
	end
endmodule
