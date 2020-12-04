`timescale 1ms / 1ns


module counterHour(
    input clk, c, rst,
    output zC
    );
    
    reg [4:0] count;
    
    integer countMax = 5'b11000;
    
    assign zC = (count == countMax) ? 1'b1 : 1'b0;
    
    always @(posedge clk, posedge rst)
        if(rst) count <= 5'b0;
        else
            if(count == countMax) count <= 5'b0;
            else if(c == 1'b1) count <= count + 1;
endmodule
