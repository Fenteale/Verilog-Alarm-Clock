`timescale 1ns / 1ps

module top (
	input clk, rst_btn,
	input sw,
	output [0:2] LED,
    output [7:0] cathode,
    output [7:0] anode
);
    wire rst;
    wire secCount, minCount, hourCount;
    wire [5:0] minCountNum;
    
    assign rst = ~rst_btn;
    
    counterSec cs_i(.clk(clk), .rst(rst), .c(sw), .zC(secCount));
    counterMin cm_i(.clk(clk), .rst(rst), .c(secCount), .count(minCountNum), .zC(minCount));
    counterHour ch_i(.clk(clk), .rst(rst), .c(minCount), .zC(hourCount));
    SevenSegmentDisplay sseg(.clk(clk), .rst(rst), .switches(minCountNum), .cathode(cathode), .anode(anode));
    

    assign LED[0] = secCount;
    assign LED[1] = minCount;
    assign LED[2] = hourCount;

endmodule