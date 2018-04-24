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
        output reg [2:0] r,    
        output reg [2:0] g,    
        output reg [1:0] b,
		  output [7:0] led,
        output hs,    
        output vs);


		//Game State
		reg [1:0] gameState, nextState;
		
		//Red Select
		reg [2:0] r0, r1, r2, r3;
		
		//Green Select
		reg [2:0] g0, g1, g2, g3;
		
		//Blue Select
		reg [1:0] b0, b1, b2, b3;
		
		//HS Select
		reg hs0, hs1, hs2, hs3;
		
		//VS Select
		reg vs0, vs1, vs2, vs3;
		
//		vga_controller(clk, keyclk, keyinput, rst, r,    
//        output reg [2:0] g,    
//        output reg [1:0] b,
//		  output [7:0] led,
//        output hs,    
//        output vs    
//        ); 
		
//Top level FSM for game state management
//State 0: Start Screen
	//Disable all user input except for "Press Enter to Start"
	//VGA output should be set to start screen VGA
	
	
//State 1: Maze Screen
	//User inputs are arrow keys
	//VGA is vga.v
	
	
//State 2: Battle State
	//User inputs are A W S D, J K L I for attack select, all others disabled
	
	
//State 3: Game End State
	//Press R to Restart


endmodule
