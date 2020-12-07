module top_test (
	input clk, rst,
	input [2:0] sw,
	output [7:0] anode,
	output [7:0] cathode
);
	assign cathode = 8'b00000000;
	assign anode = {5'b11111, ~sw[2:0]};
endmodule