module modeSel (
	input clk, rst,
	input a, b, c,
	output reg [1:0] s
);
wire [2:0] i;
assign i = {a, b, c};

always@ (posedge clk, posedge rst)
		if(rst) s <= 2'b00;
		else
			case(i)
				3'b100:		s<= 2'b10;
				3'b010:		s<= 2'b01;
				3'b001:		s<= 2'b00;
				default:	s<= s; 
			endcase

endmodule