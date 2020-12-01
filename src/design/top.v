`timescale 1ns / 1ps

module top (
	input clk, rst,
	output [2:0] test
);
	counter c_int(.clk(clk), .rst(rst), .rotate(1'b1), .switch(test));


endmodule