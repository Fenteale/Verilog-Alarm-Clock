`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/24/2020 07:08:45 PM
// Design Name: 
// Module Name: ssd
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module fixDec(
	input [15:0] switches,
	output reg [15:0] modSwitches
);
	always @ (*) begin
		modSwitches = switches;
		if(switches[3:0] > 4'b1001)
			modSwitches = modSwitches + 16'b0000000000000110;
		if(modSwitches[7:4] > 4'b1001)
			modSwitches = modSwitches + 16'b0000000001100000;
	end
endmodule


module SevenSegmentDisplay(
input           wire clk,         //100Mhz clock
input           wire rst,         //HA asynchronous reset
input    wire [15:0] switches,    //data to display on Seven Segment Display
output   wire [ 7:0] cathode,     //seven segment cathode signals
output   wire [ 7:0] anode        //seven segment anode signals
);
wire [3:0] HexVal;
wire rotate;
wire [ 2:0] switch;       //for testing
wire [15:0] modSwitches;

//fixDec fd(.switches(switches), .modSwitches(modSwitches));
BCD bcd (.binary(switches[7:0]), .decimal(modSwitches[12:0]));
rotater rotater (.clk(clk), .rst(rst), .rotate(rotate));
shift shift (.clk(clk), .rotate(rotate), .rst(rst), .anode(anode[7:0]));
counter_7seg counter(.clk(clk), .rst(rst), .rotate(rotate), .switch(switch[2:0]));
mux8to1 mux8to1(.switches(modSwitches[15:0]), .switch(switch[2:0]), .HexVal(HexVal[3:0]));
//mux8to1 mux8to1(.switches(switches[15:0]), .switch(switch[2:0]), .HexVal(HexVal[3:0]));
hextosgg hextosgg(.HexVal(HexVal[3:0]), .cathode(cathode[7:0]));

endmodule
