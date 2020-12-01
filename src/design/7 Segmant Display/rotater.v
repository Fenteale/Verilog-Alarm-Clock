`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/24/2020 07:20:16 PM
// Design Name: 
// Module Name: rotater
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




module rotater(
input clk, rst,
output wire rotate
);
reg [12:0] count, ncount;

assign rotate = (count == 13'd4999);

always @(posedge clk, posedge rst)
    if (rst) count <= 18'b0; 
    else count <= ncount;
    
always @(*) 
    if (rotate) ncount <= 18'b0;
    else ncount <= count + 18'b1;
    
endmodule