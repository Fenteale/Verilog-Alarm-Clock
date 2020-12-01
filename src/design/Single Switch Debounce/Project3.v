`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/08/2020 01:26:50 PM
// Design Name: 
// Module Name: Project3
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


module Project3(clk,rst,button,anode,cathode);

input clk,rst,button;
output [7:0] anode, cathode;

reg [7:0] cathode;
reg [3:0] nibble;
reg[2:0] a_cnt,na_cnt;
reg [16:0] t_cnt,nt_cnt;
reg[7:0] anode,n_anode;
reg[31:0] counter,n_counter;
wire tick;
wire ped;
wire [31:0] data;

DebouncePed dbp(
.clk(clk),
.rst(rst),
.tick(tick),
.button(button),
.ped(ped));

assign tick = t_cnt == 17'd99_999;

always@(*)
if(tick) nt_cnt=17'b0;
else nt_cnt = t_cnt +17'b1;

always@(posedge clk, posedge rst)
if(rst) t_cnt <= 17'b0;
else t_cnt<=nt_cnt;

always@(*) 
if(ped) n_counter = counter +32'b1;
else n_counter = counter;

always@(posedge clk, posedge rst)
if(rst) counter <= 32'b0;
else counter <= n_counter;

assign data = counter;

always@(*)
case(a_cnt)
3'b000:nibble = data[3:0];
3'b001:nibble = data[7:4];
3'b010:nibble = data[11:8];
3'b011:nibble = data[15:12];
3'b100:nibble = data[19:16];
3'b101:nibble = data[23:20];
3'b110:nibble = data[27:24];
3'b111:nibble = data[31:28];
endcase

always@(*)
case (nibble)
4'b0000: cathode = 8'hC0;
4'b0001: cathode = 8'hF9;
4'b0010:cathode = 8'hA4;
4'b0011:cathode = 8'hB0;
4'b0100: cathode = 8'h99;
4'b0101: cathode = 8'h92;
4'b0110:cathode = 8'h82;
4'b0111:cathode = 8'hF8;
4'b1000: cathode = 8'h80;
4'b1001: cathode = 8'h90;
4'b1010:cathode = 8'h88;
4'b1011:cathode = 8'h83;
4'b1100: cathode = 8'hC6;
4'b1101: cathode = 8'hA1;
4'b1110:cathode = 8'h86;
4'b1111:cathode = 8'h8E;
endcase

always@(posedge clk, posedge rst)
if(rst) {a_cnt,anode} <={3'b0,8'hFE};
else {a_cnt,anode} <={na_cnt,n_anode};

always@(*)
if (tick) na_cnt = a_cnt +3'b1;
else na_cnt = a_cnt;

always@(*)
if(tick) n_anode = {anode[6:0],anode[7]};
else n_anode = anode;

endmodule

