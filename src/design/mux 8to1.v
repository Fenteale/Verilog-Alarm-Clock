`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/25/2020 06:30:44 PM
// Design Name: 
// Module Name: mux 8to1
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


module mux8to1(
    input [15:0] switches,
    input [2:0] switch,
    output reg [3:0] HexVal
    );
    
always @ (*)
  begin
    case(switch)
        3'b000: HexVal[3:0] = switches[3:0];
        3'b001: HexVal[3:0] = switches[7:4];
        3'b010: HexVal[3:0] = switches[11:8];
        3'b011: HexVal[3:0] = switches[15:12];
        default:HexVal[3:0] = switches[3:0];
        /*
        3'b100: HexVal[3:0] = switches[3:0];
        3'b101: HexVal[3:0] = switches[7:4];
        3'b110: HexVal[3:0] = switches[11:8];
        3'b111: HexVal[3:0] = switches[15:12];
        */
    endcase
  end

endmodule
