`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/08/2020 01:46:08 PM
// Design Name: 
// Module Name: Project3_tb
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


module Project3_tb();
reg clk,rst,button;
wire [7:0] anode,cathode;
integer i;

Project3 Project3(
.clk(clk),
.rst(rst),
.button(button),
.anode(anode[7:0]),
.cathode(cathode[7:0])
);

always #5 clk=~clk;

initial begin
clk=0;
rst=1;
button=0;
i=0;
#100
rst=0;
#100
for(i=0;i<16;i=i+1)
begin
button = 1;
#15_000_000
button = 0;
#15_000_000;
end
end

endmodule
