`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/25/2020 06:37:54 PM
// Design Name: 
// Module Name: hextossg
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


module hextosgg(
input wire [3:0] HexVal,
output reg [7:0] cathode
);
    
always @(*) 
  begin 
    case(HexVal)
        4'h0: cathode[7:0] = 7'h3F;
        4'h1: cathode[7:0] = 7'h06;
        4'h2: cathode[7:0] = 7'h5B;
        4'h3: cathode[7:0] = 7'h4F;
        4'h4: cathode[7:0] = 7'h66;
        4'h5: cathode[7:0] = 7'h6D;
        4'h6: cathode[7:0] = 7'h7D;  
        4'h7: cathode[7:0] = 7'h07;
        4'h8: cathode[7:0] = 7'h7F;
        4'h9: cathode[7:0] = 7'h6F;
        4'hA: cathode[7:0] = 7'h77; 
        4'hB: cathode[7:0] = 7'h7C;
        4'hC: cathode[7:0] = 7'h39; 
        4'hD: cathode[7:0] = 7'h5E;
        4'hE: cathode[7:0] = 7'h79;
        4'hF: cathode[7:0] = 7'h71;
    endcase 
    cathode = ~cathode;    
end       
endmodule
