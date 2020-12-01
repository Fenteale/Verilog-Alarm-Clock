`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/01/2020 05:13:27 PM
// Design Name: 
// Module Name: coiunterMin_sim
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


module counterMin_sim(

    );
    
    reg clk, reset;
    wire zC;
    
    counterMin cm_sim(.clk(clk), .reset(reset), .zC(zC));
    
    initial forever begin
        #10
        clk = ~clk;
    end
    
    initial begin
        clk = 0;
        reset = 1;
        #20
        reset = 0;
   end
endmodule
