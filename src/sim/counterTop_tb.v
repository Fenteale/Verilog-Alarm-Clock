`timescale 1ms / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/03/2020 06:43:51 PM
// Design Name: 
// Module Name: counterTop_tb
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


module counterTop_tb(

    );
    reg clk, rst;
    reg count;
    wire secCount, minCount, hourCount;
    
    counterSec cs_i(.clk(clk), .rst(rst), .c(count), .zC(secCount));
    counterMin cm_i(.clk(clk), .rst(rst), .c(secCount), .zC(minCount));
    counterHour ch_i(.clk(clk), .rst(rst), .c(minCount), .zC(hourCount));
    
    always #0.01 clk = ~clk;

    initial begin

    clk = 0; count = 0; rst = 1;
    #1
    rst = 0;
    #10;
    count = 1;
    end
endmodule
