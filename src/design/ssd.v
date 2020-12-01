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

rotater rotater (.clk(clk), .rst(rst), .rotate(rotate));
shift shift (.clk(clk), .rotate(rotate), .rst(rst), .anode(anode[7:0]));
counter counter(.clk(clk), .rst(rst), .rotate(rotate), .switch(switch[2:0]));
mux8to1 mux8to1(.switches(switches[15:0]), .switch(switch[2:0]), .HexVal(HexVal[3:0]));
hextosgg hextosgg(.HexVal(HexVal[3:0]), .cathode(cathode[7:0]));

endmodule