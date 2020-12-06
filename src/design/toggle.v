module toggle (
	input clk, rst, t,
	output reg s
);
	//reg s;

	always@ (posedge clk, posedge rst)
		if(rst) s <= 1'b0;
		else if(t) s <= ~s;
endmodule