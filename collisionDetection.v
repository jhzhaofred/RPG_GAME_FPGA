`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:17:46 04/19/2018 
// Design Name: 
// Module Name:    collisionDetection 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module collisionDetection(position, e_position, pblockposx, pblockposy, enemyCollide);

	input [19:0] position;
	input [19:0] e_position;
	
	output [5:0] pblockposx, pblockposy;
	//output wallCollide;
	output reg enemyCollide;
	
	//reg [0:1199] collisionMatrix = 1200'b101111111111111111111111111111111111111110000000000100000000000000000000000000011101111101010101111111111111111111110101100000010101010001000100000000000100010110111101011101111101010101011111110101011001000100010000010101010101000100010101110101111101111101010101011101010111010110010000010001000101000100000101000101011011111101010101110101111111110111010101100000010101000100010000000001010101010110010101011111110111110101110101010111011001010100000001010001010001010001000101100101011111110101010101110101111111010110010100000001010101010001010100010001011011011111110101010101010111010101011111100100000001010001010101000101010001000110011111010101111111011111010101111111011000000101010001000001000001010000000101101111010101110101111101111101111111010110010001010001000100010000010000000100011001011111110111110101111111111111011111100101000001000001010000000100010001000110010101111111010111011111010101011101011001000101000101000101000001010001000101100111110101010111011101011101111101010110010001010101000100000100010100010101011001010101010111011111111111010101010101100001000101000100000001000100010001010110111111110111011111111101011111111111011111111111111111111111111111111111111101;

	
	/*
		xpos <= position[19:10];
		ypos <= position[9:0];
	*/
	
	initial begin
		enemyCollide = 1'b0;
	end
	
	assign pblockposx = position[19:10]/10'd16;
	assign pblockposy = position[9:0]/10'd16;
	
	//assign wallCollide = collisionMatrix[pblockposy * 40 + pblockposx] ? 1'b1 : 1'b0;
	
	//Always at position change
	always @ (position or e_position) begin

	//right collision, checked, works
		//If horizontal collision, enemy to the right
		if(e_position[19:10] >= position[19:10] && e_position[19:10] <= position[19:10] + 10'd16) begin
			//if vertical collision, enemy down, checked, works
			if(e_position[9:0] >= position[9:0] && e_position[9:0] <= position[9:0] + 10'd16) begin
				enemyCollide <= 1'b1;
			end
			//if vertical collision, enemy up, checked, works
			else if(e_position[9:0] <= position[9:0] && e_position[9:0] + 10'd16 >= position[9:0]) begin
  				enemyCollide <= 1'b1;
			end
		end	
		
	//left collision, checked, works
		//If horizontal collision, enemy to the left
		else if(position[19:10] >= e_position[19:10] && position[19:10] <= e_position[19:10] + 10'd16) begin
			//if vertical collision, enemy down, checked, works
			if(e_position[9:0] >= position[9:0] && e_position[9:0] <= position[9:0] + 10'd16) begin
				enemyCollide <= 1'b1;
			end
			//if vertical collision, enemy up, checked, works
			else if(e_position[9:0] <= position[9:0] && e_position[9:0] + 10'd16 >= position[9:0]) begin
  				enemyCollide <= 1'b1;
			end
		end
		
		else
			enemyCollide <= 1'b0;
	end


endmodule
