`timescale 1ms / 1ns

module counter
	#(parameter BITS = 6,
		parameter MAX_VAL = 60) (
    input clk, c, rst,
    output zC,
    output reg [BITS-1:0] count
    );
    
    assign zC = (count == MAX_VAL) ? 1'b1 : 1'b0;
    
    always @(posedge clk, posedge rst)
        if(rst) count <= 0;
        else
            if(count == MAX_VAL) count <= 0;
            else if(c == 1'b1) count <= count + 1;
endmodule