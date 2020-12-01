`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/24/2020 11:29:42 PM
// Design Name: 
// Module Name: counter
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

module counter(
input clk, rst, rotate,
output reg [2:0] switch
);
    
always @(posedge clk, posedge rst)
    if (rst) switch <= 3'b0;
    else if (rotate) switch <= switch + 3'b1;
    
endmodule

