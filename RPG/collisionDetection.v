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
module collisionDetection(position, e_position, pblockposx1, pblockposy1, pblockposx2, pblockposy2, pblockposx3, pblockposy3, pblockposx4, pblockposy4, enemyCollide);

	input [19:0] position;
	input [19:0] e_position;
	
	output [5:0] pblockposx1, pblockposy1, pblockposx2, pblockposy2, pblockposx3, pblockposy3, pblockposx4, pblockposy4;
	output reg enemyCollide;
	
	/*
		xpos <= position[19:10];
		ypos <= position[9:0];
	*/
	
	initial begin
		enemyCollide = 1'b0;
	end

	//up
	assign pblockposx1 = (position[19:10] - 10'd144)/10'd32;
	assign pblockposy1 = (position[9:0] - 10'd31 - 5'd2)/10'd32;
	
	//right
	assign pblockposx2 = (position[19:10] - 10'd144 + 10'd16 + 5'd2)/10'd32;
	assign pblockposy2 = (position[9:0] - 10'd31)/10'd32;
	
	//down
	assign pblockposx3 = (position[19:10] - 10'd144)/10'd32;
	assign pblockposy3 = (position[9:0] - 10'd31 + 10'd16 + 5'd2)/10'd32;
	
	//left
	assign pblockposx4 = (position[19:10] - 10'd144 - 5'd2)/10'd32;
	assign pblockposy4 = (position[9:0] - 10'd31)/10'd32;
	
	
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
