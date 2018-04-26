`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:25:26 04/23/2018 
// Design Name: 
// Module Name:    GameTop 
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
module GameTop(input clk,   
		  input keyclk,		  
		  input keyinput,
        input rst,
		  input [7:0] switch,
        output reg [2:0] r,    
        output reg [2:0] g,    
        output reg [1:0] b,
		  output [7:0] led,
        output reg hs,    
        output reg vs);


		//Game State
		reg [1:0] gameState = 2'b00;
		
		//Red Select
		wire [2:0] r0, r1, r2, r3;
		
		//Green Select
		wire [2:0] g0, g1, g2, g3;
		
		//Blue Select
		wire [1:0] b0, b1, b2, b3;
		
		//HS Select
		wire hs0, hs1, hs2, hs3;
		
		//VS Select
		wire vs0, vs1, vs2, vs3;
		
		wire enemyCollide, switchState, switchState0, switchState1, switchState2, switchState3, winBattle, winGame;
		
		assign switchState = (switchState0 || switchState1 || switchState2 || switchState3);
		
//Top level FSM for game state management
//State 0: Start Screen
	//Disable all user input except for "Press Enter to Start"
	//VGA output should be set to start screen VGA
	 start_screen 					s0(clk, rst, switch[6:0], r0, g0, b0, hs0, vs0);
	
//State 1: Maze Screen
	//User inputs are arrow keys
	//VGA is vga.v
	vga_controller					vga1(clk, keyclk, keyinput, rst, r1, g1, b1, led, hs1, vs1, enemyCollide);//, switchState1);
	
//State 2: Battle State
	//User inputs are A W S D, J K L I for attack select, all others disabled
	 battle_screen 				bs0(clk, rst, switch[6:0], r2, g2, b2, hs2, vs2);
	
//State 3: Game End State
	//Press R to Restart
	
	always @ (posedge clk) begin
		case(gameState)
			2'b00: begin
						r <= r0;
						g <= g0;
						b <= b0;
						hs <= hs0;
						vs <= vs0;
							if(switch[7]) begin
								gameState <= 2'b01;
							end
							
							else begin
								gameState <= 2'b00;
							end
						
					 end
			2'b01: begin
						r <= r1;
						g <= g1;
						b <= b1;
						hs <= hs1;
						vs <= vs1;
							if(enemyCollide) begin
								gameState <= 2'b10;
							end
							
							else begin
								gameState <= 2'b01;
							end
						
					 end
			2'b10: begin
						r <= r2;
						g <= g2;
						b <= b2;
						hs <= hs2;
						vs <= vs2;
							if(winGame) begin
								gameState <= 2'b11;
							end
							
							else if(switch[7]) begin
								gameState <= 2'b01;
							end
					 end
			2'b11: begin
						r <= r3;
						g <= g3;
						b <= b3;
						hs <= hs3;
						vs <= vs3;
						gameState <= 2'b00;
					 end
		endcase
	end
endmodule
