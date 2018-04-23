`timescale 1ns / 1ps

module Ranger(
	input clk,
	input [2:0] rangerNum,
	input [3:0] inputs,
	output [19:0] position
    );
	 
	//Enemy initial positions here
	reg [9:0] a_hpos = 255;
   reg [9:0] a_vpos = 240;  
	
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
