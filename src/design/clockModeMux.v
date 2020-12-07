module clockMux (
	input [15:0] a, b, c, d,
	input [1:0] sel,
	output reg [15:0] out
);

	always @(*)
		case(sel)
			2'b00: out <= a;
			2'b01: out <= b;
			2'b10: out <= c;
			2'b11: out <= d;
			default: out <= a;
		endcase
endmodule