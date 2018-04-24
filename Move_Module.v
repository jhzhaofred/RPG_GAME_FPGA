`timescale 1ns / 1ps

module Move_Module(
	input [19:0] e_position,
	input [19:0] e_position2,
	input [19:0] e_position3,
	input [19:0] e_position4,
	input [19:0] e_position5,
	input clk,
	input [3:0] inputs,
	output reg enemyCollide,
	output [19:0] newPosition
    );
	 
//        parameter UP_BOUND = 31;    
//        parameter DOWN_BOUND = 510;    
//        parameter LEFT_BOUND = 144;    
//        parameter RIGHT_BOUND = 783;

	//Initialize Player position here
	reg [9:0] a_hpos = 180;
   reg [9:0] a_vpos = 32; 
	
	assign newPosition = {a_hpos,a_vpos};

	//Collision Detection Signals
	wire [5:0] pblockposx1, pblockposy1, pblockposx2, pblockposy2, pblockposx3, pblockposy3, pblockposx4, pblockposy4;
	wire wallCollide, enemyCollideWire, enemyCollideWire2, enemyCollideWire3, enemyCollideWire4, enemyCollideWire5, wallCollide1, wallCollide2, wallCollide3;	
	
	reg [0:299] collisionMatrix = 300'b101111111111111111111000000000001000000111111111111010101101100000100010101001011010101110101010010110101000001010100101101011111110101101011010000010001000010110111110101010100101101000001010001001011010111110101111010110100010001010000101101110111111101011011000100000000010000111111111111111111101;
		  
	assign wallCollide1 =  collisionMatrix[pblockposy1 * 20 + pblockposx1] ? 1'b1 : 1'b0;
	assign wallCollide2 =  collisionMatrix[pblockposy2 * 20 + pblockposx2] ? 1'b1 : 1'b0;
	assign wallCollide3 =  collisionMatrix[pblockposy3 * 20 + pblockposx3] ? 1'b1 : 1'b0;
	assign wallCollide4 =  collisionMatrix[pblockposy4 * 20 + pblockposx4] ? 1'b1 : 1'b0;
	
	collisionDetection		cd2({a_hpos, a_vpos}, e_position, pblockposx1, pblockposy1, pblockposx2, pblockposy2, pblockposx3, pblockposy3, pblockposx4, pblockposy4, enemyCollideWire);
	collisionDetection		cd3({a_hpos, a_vpos}, e_position2, , , , , , , , , enemyCollideWire2);
	collisionDetection		cd4({a_hpos, a_vpos}, e_position3, , , , , , , , , enemyCollideWire3);
	collisionDetection		cd5({a_hpos, a_vpos}, e_position4, , , , , , , , , enemyCollideWire4);
	collisionDetection		cd6({a_hpos, a_vpos}, e_position5, , , , , , , , , enemyCollideWire5);
	
	always@(posedge clk) begin
		//If enemyCollide, then move back to where you were
		if(enemyCollideWire || enemyCollideWire2 || enemyCollideWire3 || enemyCollideWire4 || enemyCollideWire5) begin
			enemyCollide <= 1'b1;
			case(inputs)
				4'b1000: a_vpos <= a_vpos + 4'd8; // up
				4'b0100: a_vpos <= a_vpos - 4'd8; // down
				4'b0010: a_hpos <= a_hpos + 4'd8; //left
				4'b0001: a_hpos <= a_hpos - 4'd8; //right
			endcase
		end
		
		else begin
			//No enemy collides,
			enemyCollide <= 1'b0;
			case(inputs)
				4'b1000: a_vpos <= wallCollide1 ? a_vpos : a_vpos - 3'd2; // up
				4'b0100: a_vpos <= wallCollide3 ? a_vpos : a_vpos + 3'd2; // down
				4'b0010: a_hpos <= wallCollide4 ? a_hpos : a_hpos - 3'd2; //left
				4'b0001: a_hpos <= wallCollide2 ? a_hpos : a_hpos + 3'd2; //right
			endcase
		end
	end
endmodule
