`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/24/2020 09:18:20 PM
// Design Name: 
// Module Name: shift
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


module shift(
input rst, rotate,
output reg [3:0] anode
    );
always @(posedge rotate, posedge rst) //always @
    if(rst) anode = 4'b1110; 
    else if(rotate) anode = {anode [2:0], anode[3]};
    

endmodule
