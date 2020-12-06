`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/08/2020 01:33:15 PM
// Design Name: 
// Module Name: DebouncePed
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module DebouncePed(clk,rst,tick,button,ped);

	input clk, rst, tick, button;
	output ped;

	reg[9:0] sh_reg,nsh_reg;
	wire db;
	reg [1:0] ped_q,nped_q;
	wire ped;

	always@(posedge clk, posedge rst)
	if(rst) {sh_reg,ped_q} <= {10'b0,2'b0};
	else {sh_reg,ped_q} <={nsh_reg,nped_q};

	always@(*)
	if(tick) nsh_reg = {sh_reg[8:0],button};
	else nsh_reg=sh_reg;

	assign db=&sh_reg;

	always@(*)
	nped_q = {db,ped_q[1]};

	assign ped = ped_q[1] & ~ped_q[0];

endmodule
