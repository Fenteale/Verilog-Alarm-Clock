module modeSel (
	input clk, rst,
	input a, b, c, d,
	output reg [1:0] s
);
wire [3:0] i;
assign i = {d, a, b, c};

always@ (posedge clk, posedge rst)
		if(rst) s <= 2'b00;
		else
			case(i)
				4'b1000:		s<= 2'b11;
				4'b0100:		s<= 2'b10;
				4'b0010:		s<= 2'b01;
				4'b0001:		s<= 2'b00;
				default:	s<= s; 
			endcase

endmodule