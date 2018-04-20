`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:04:00 03/24/2018 
// Design Name: 
// Module Name:    game_engin 
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
module game_engin( input collision_detected, // to start the battle
						 input [1:0] player_choice, // to choose attack type
						 input [1:0] enemy_choice,
						 output [6:0] player_HB, //player's health condition to be shown on the monitor
						 output [6:0] enemy_HB,
						 output [4:0] player_remained_sword,//punchs and kicks are infinite 
						 output [4:0] player_remained_baseballbat,//needed to be shown on the screen
						 output [4:0] enemy_remained_sword,
						 output [4:0] enemy_remained_baseballbat,
						 output player_win,
						 output enemy_win
    );


parameter P=2'b00, K=2'b01, S=2'b10, B=2'b11;
///////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////These initial numbers can be changed/////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////

initial
begin
player_HB = 7'd100;
enemy_HB = 7'd100;
end


initial
begin 
player_remained_sword = 5'd4;
player_remained_baseballbat = 5'd3;

enemy_remained_sword = 5'd4;
enemy_remained_baseballbat = 5'd3;
end

//Full Health Bar is 100
//We need to deciede on these numbers
//assign Punch_Accuracy = 100; 
//assign Puch_Power = 5; 
//assign Kick_Accuracy = 80;
//assign Kick_Power = 10;
//assign Sword_Accuracy = 40;
//assign Sword_Power = 20;
//assign BaseballBat_Accuracy = 30;
//assign BaseballBat_Power = 40;

//Strength levels should have overlap to to prevent the attackers from using different attack types in their power order



///////////////////////////////////////////////////////////////////////////////////////////////////
always @(posedge clk)
begin
if (player_HB == 0)
		enemy_win = 1'b1;
else if (enemy_HB == 0)
		player_win = 1'b1;
end
///////////////////////////////////////////////////////////////////////////////////////////////////
always @(posedge clk)
begin
if(collision_detected == 1)
begin
		case (player_choice)
		
			P: 
				
					enemy_HB = enemy_HB - Puch_Power;
			
			K:
				
					enemy_HB = enemy_HB - Kick_Power;

	
			S:begin
				if (player_remained_sword > 0)
				begin

					enemy_HB = enemy_HB - Sword_Power;
					player_remained_sword = player_remained_sword - 1;
					
				end
			end
			
			B:begin
				if (player_remained_baseballbat > 0)
				begin
					
					enemy_HB = enemy_HB - BaseballBat_Power;
					player_remained_baseballbat = player_remained_baseballbat - 1;

				end
			end
		endcase
end
end
//////////////////////////////////////some parts of the previous always block should be added here/////////////////////
always @(posedge clk)
begin
if(collision_detected == 1)
begin
		case (enemy_choice)
		
			P: 
					player_HB = player_HB - Puch_Power;
			
			K:
				
					player_HB = player_HB - Kick_Power;
				
	
			S:begin
				if (enemy_remained_sword > 0)
				begin

					player_HB = player_HB - Sword_Power;
					enemy_remained_sword = enemy_remained_sword - 1;
					
				end
			end
			
			B:begin
				if (enemy_remained_baseballbat > 0)
				begin
					
					player_HB = player_HB - BaseballBat_Power;
					enemy_remained_baseballbat = enemy_remained_baseballbat - 1;

				end
			end
		endcase
end
end
///////////////////////////////////////////////////////////////////////////////////////////////////

endmodule

