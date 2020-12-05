`timescale 1ns / 1ps

module top (
	input clk, rst_btn,
	input sw,
	output [0:2] LED,
    output [7:0] cathode,
    output [7:0] anode
);
    wire rst;
    wire tickCount, secCount, minCount, hourCount;
    wire [7:0] secCountNum, minCountNum;
    
    assign rst = ~rst_btn;
    
    counter #(.BITS(27), .MAX_VAL(100000000)) ct_i(.clk(clk), .rst(rst), .c(sw), .zC(tickCount)); //counter each tick
    counter #(.BITS(6), .MAX_VAL(60)) cs_i(.clk(clk), .rst(rst), .c(tickCount), .count(secCountNum[5:0]), .zC(secCount)); //counts seconds
    counter #(.BITS(6), .MAX_VAL(60)) cm_i(.clk(clk), .rst(rst), .c(secCount), .count(minCountNum[5:0]), .zC(minCount)); //counts minutes
    counter #(.BITS(5), .MAX_VAL(24)) ch_i(.clk(clk), .rst(rst), .c(minCount), .zC(hourCount)); //counts hours
    SevenSegmentDisplay sseg(.clk(clk), .rst(rst), .switches({minCountNum, secCountNum}), .cathode(cathode), .anode(anode));
    

    assign LED[0] = secCount;
    assign LED[1] = minCount;
    assign LED[2] = hourCount;

endmodule