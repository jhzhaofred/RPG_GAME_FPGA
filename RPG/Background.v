`timescale 1ns / 1ps

module Background(clk, clk_1s, h_count, v_count,color);
input clk, clk_1s;
input [9:0] h_count,v_count;
output [7:0] color;
wire [7:0] grass, flower, flower_0, flower_1;
reg [3:0] count = 0;
assign color = !(v_count >= 31 && v_count <= 510 && h_count >= 144 && h_count <= 783) ? 8'b00000000 : 
					!(v_count >= 143 && v_count <= 190 && h_count >= 625 && h_count <= 688) ? grass : 
					(((v_count - 143)/8)%2 == 1  && ((h_count - 625)/8)% 2 == 0 ) ? grass : 
					(((v_count - 143)/8)%2 == 0  && ((h_count - 625)/8)% 2 == 1 ) ? grass : flower;

Grass GrassBackground (
  .clka(clk), // input clka
  .addra((v_count%8) * 8 + h_count%8), // input [5 : 0] addra
  .douta(grass) // output [7 : 0] douta
);

assign flower = count[3] == 1 ? flower_0 : flower_1;

flower f0 (
  .clka(clk), // input clka
  .addra(((v_count - 31)%8) * 8 + (h_count - 144)%8), // input [5 : 0] addra
  .douta(flower_0) // output [7 : 0] douta
);

flower f1 (
  .clka(clk), // input clka
  .addra(((v_count - 31)%8) * 8 + (7 - (h_count - 144)%8)), // input [5 : 0] addra
  .douta(flower_1) // output [7 : 0] douta
);

always@(posedge clk_1s) count = count + 1;
endmodule
