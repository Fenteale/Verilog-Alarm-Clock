`timescale 1ns / 1ps


module counterHour(
    input z602, reset,
    output cH 
    );
    
    reg [4:0] count;
    
    assign cH = (count == 5'b11000) ? 1'b1 : 1'b0;
    
    always @(posedge z602, posedge reset)
        if(reset) count <= 5'b0;
        else
            if(count == 5'b11000) 
                count <= 5'b11000;
            else   count <= count + 1;
endmodule
