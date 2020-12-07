module flop(
	input clk, rst, s, r,
	output reg o
);
	always@(posedge clk, posedge rst) begin
		if(rst) o <= 1'b0;
		else begin
			if(r) o <= 1'b0;
			else if(s) o <= 1'b1;
		end
	end
endmodule