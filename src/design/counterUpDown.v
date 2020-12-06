`timescale 1ms / 1ns

module counterUpDown
	#(parameter BITS = 6,
		parameter MAX_VAL = 60) (
    input clk, c, cu, cd, rst,
    output zC,
    output reg [BITS-1:0] count
    );
    
    assign zC = (count == MAX_VAL) ? 1'b1 : 1'b0;
    
    always @(posedge clk, posedge rst)
        if(rst) count <= 0;
        else begin
            if(count >= MAX_VAL) count = 0;
            else if(c) begin
              if(cu) count = count + 1;
              else if(cd) count = count - 1;
            end
        end
endmodule

/*
module counterUpDown
	#(parameter BITS = 6,
		parameter MAX_VAL = 60) (
    input cu, cd, rst,
    output zC,
    output reg [BITS-1:0] count
    );
    
    assign zC = (count == MAX_VAL) ? 1'b1 : 1'b0;
    
    always @(*)
        if(rst) count <= 0;
        else if(cu) begin
          count = count + 1;
          if (count == MAX_VAL) count = 0;
        end
        else if(cd) begin
          count = count - 1;
          if (count == 0) count = MAX_VAL - 1;
        end
endmodule
*/