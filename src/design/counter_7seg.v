
`timescale 1ns / 1ps

module counter_7seg(
input clk, rst, rotate,
output reg [2:0] switch
);

always @(posedge clk, posedge rst)
    if (rst) switch <= 3'b0;
    else if (rotate) switch <= switch + 3'b1;

endmodule