`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/01/2020 05:08:19 PM
// Design Name: 
// Module Name: counterMin
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


module counterMin(
    input clk, reset,
    output zC 
    );
    
    reg [5:0] count;
    
    assign zC = (count == 6'd60) ? 1'b1 : 1'b0;
    
    always @(posedge clk, posedge reset)
        if(reset) count <= 6'b0;
        else
            if(count == 6'd60) count <= 6'b0;
            else   count <= count + 1;
endmodule
