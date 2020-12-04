`timescale 1ns / 1ps

module counterSec(
    input clk, rst,c,
    output z60 
    );
    
    reg [26:0] count;
    
    assign z60 = (count == 27'b101111101011110000100000000) ? 1'b1 : 1'b0;
    
    always @(posedge clk, posedge rst)
        if(rst) count <= 27'b0;
        else
            if(count == 27'b101111101011110000100000000 || c == 1'b0) count <= 27'b0;
            else   count <= count + 1;
endmodule