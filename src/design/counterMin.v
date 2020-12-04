`timescale 1ns / 1ps

module counterMin(
    input z60, rst,
    output z602
    );
    
    reg [26:0] count;
    
    assign z602 = (count == 27'b101111101011110000100000000) ? 1'b1 : 1'b0;
    
    always @(posedge z60, posedge rst)
        if(rst) count <= 27'b0;
        else
            if(count == 27'b101111101011110000100000000 || z60 == 1'b0) count <= 27'b0;
            else   count <= count + 1;
endmodule