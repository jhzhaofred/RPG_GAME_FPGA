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
	output reg enemyCollide;
	
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
			
			//if purely horizontal collision
			else if(e_position[9:0] == position[9:0] && e_position[9:0] + 10'd16 == position[9:0]) begin
  				enemyCollide <= 1'b1;
			end
			
			//No collision
			else
				enemyCollide <= 1'b0;
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
			
			//if purely horizontal collision
			else if(e_position[9:0] == position[9:0] && e_position[9:0] + 10'd16 == position[9:0]) begin
  				enemyCollide <= 1'b1;
			end
			
			//No collision
			else
				enemyCollide <= 1'b0;
		end
		
		else
			enemyCollide <= 1'b0;
	end

endmodule
