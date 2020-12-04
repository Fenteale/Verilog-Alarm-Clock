`timescale 1ms / 1ns

module counterSec(
    input clk,rst,c,
    output zC 
    );
    wire newWire;
    reg [26:0] count;
    
    integer countMax = 27'b101111101011110000100000000;
    
    assign zC = (count == countMax) ? 1'b1 : 1'b0;
    
    always @(posedge clk, posedge rst)
        if(rst) count <= 27'b0;
        else
            if(count == countMax) count <= 27'b0;
            else if(c == 1'b1) count <= count + 1;
endmodule