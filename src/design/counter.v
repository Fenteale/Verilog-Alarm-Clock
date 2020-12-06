`timescale 1ms / 1ns

module counter
	#(parameter BITS = 6,
		parameter MAX_VAL = 60) (
    input clk, c, rst, set,
    input [BITS-1:0] countSet,
    output zC,
    output reg [BITS-1:0] count
    );
    
    assign zC = (count == MAX_VAL);
    
    always @(posedge clk, posedge rst)
        if(rst) count <= 0;
        else
            if(set) begin
              count <= countSet;
            end
            else begin
              if(count == MAX_VAL) count <= 0;
              else if(c == 1'b1) count <= count + 1;
            end
endmodule