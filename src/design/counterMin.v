`timescale 1ms / 1ns

module counterMin(
    input clk, c, rst,
    output zC,
    output reg [5:0] count
    );
    
    
    integer countMax = 6'b111100;
    
    assign zC = (count == countMax) ? 1'b1 : 1'b0;
    
    always @(posedge clk, posedge rst)
        if(rst) count <= 6'b0;
        else
            if(count == countMax) count <= 6'b0;
            else if(c == 1'b1) count <= count + 1;
endmodule