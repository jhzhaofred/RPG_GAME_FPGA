`timescale 1ns / 1ps

module Move_Module(
	input [19:0] e_position,
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
	reg [9:0] a_hpos = 177;
   reg [9:0] a_vpos = 32; 
	
	assign newPosition = {a_hpos,a_vpos};

	//Collision Detection Signals
	wire [5:0] pblockposx, pblockposy;
	wire wallCollide, enemyCollideWire;	
	
	reg [0:299] collisionMatrix = 300'b101111111111111111111000000000001000000111111111111010101101100000100010101001011010101110101010010110101000001000100101101011111111111101011010000010001000010110111110101010100101101000001010001001011010111110101111010110100010001010000101101110111111101011011000100000000010000111111111111111111101;
	
	assign wallCollide =  collisionMatrix[pblockposy * 20 + pblockposx] ? 1'b1 : 1'b0;
	
	collisionDetection		cd2({a_hpos, a_vpos}, e_position, pblockposx, pblockposy, enemyCollideWire);
	
	always@(posedge clk) begin
		//If enemyCollide, then move back to where you were
		if(enemyCollideWire) begin
			enemyCollide <= 1'b1;
			case(inputs)
				4'b1000: a_vpos <= a_vpos + 4'd12; // up
				4'b0100: a_vpos <= a_vpos - 4'd12; // down
				4'b0010: a_hpos <= a_hpos + 4'd12; //left
				4'b0001: a_hpos <= a_hpos - 4'd12; //right
			endcase
		end
		
		else if(wallCollide && !enemyCollideWire) begin
			//If wallCollide, move back to where you were
			enemyCollide <= 1'b0;
			case(inputs)
				4'b1000: a_vpos <= a_vpos + 4'd12; // up
				4'b0100: a_vpos <= a_vpos - 4'd12; // down
				4'b0010: a_hpos <= a_hpos + 4'd12; //left
				4'b0001: a_hpos <= a_hpos - 4'd12; //right
			endcase
		end
		
		else begin
			//No collides, move as normal
			enemyCollide <= 1'b0;
			case(inputs)
				4'b1000: a_vpos <= a_vpos - 3'd4; // up
				4'b0100: a_vpos <= a_vpos + 3'd4; // down
				4'b0010: a_hpos <= a_hpos - 3'd4; //left
				4'b0001: a_hpos <= a_hpos + 3'd4; //right
			endcase
		end
	end
endmodule
