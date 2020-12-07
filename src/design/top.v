`timescale 1ns / 1ps

module top (
	input clk, rst_btn, btn_c, btn_u, btn_d, btn_l, btn_r,
	input [2:0] sw,
	output [4:0] LED,
    output [7:0] cathode,
    output [7:0] anode
);
    wire rst;
    wire tickCount, secCount, minCount, hourCount, db_tick;
    wire [1:0] showSet;
    wire db_co, db_uo, db_do, db_lo, db_ro;
    wire [7:0] secCountNum, minCountNum, hourCountNum, dbCountTicks;

    wire [15:0] clkTime, clkSet, clkAlarm, ssegDisp;

    assign clkTime = {hourCountNum, minCountNum};

    clockMux cm (.a(clkTime), .b(clkSet), .c(clkAlarm), .sel(showSet), .out(ssegDisp));
    
    assign rst = ~rst_btn;

    wire setTime;
    assign setTime = AsetTime || CsetTime;


    //toggle tg (.clk(clk), .rst(rst), .t(db_lo), .s(showSet));
    modeSel ms (.clk(clk), .rst(rst), .a(db_ro), .b(db_lo), .c(setTime), .s(showSet));

    counter #(.BITS(17), .MAX_VAL(99999)) dbcounter(.clk(clk), .rst(rst), .c(sw), .zC(db_tick));
    DebouncePed dbc (.clk(clk),.rst(rst), .tick(db_tick), .button(btn_c), .ped(db_co));
    DebouncePed dbu (.clk(clk),.rst(rst), .tick(db_tick), .button(btn_u), .ped(db_uo));
    DebouncePed dbd (.clk(clk),.rst(rst), .tick(db_tick), .button(btn_d), .ped(db_do));
    DebouncePed dbl (.clk(clk),.rst(rst), .tick(db_tick), .button(btn_l), .ped(db_lo));
    DebouncePed dbr (.clk(clk),.rst(rst), .tick(db_tick), .button(btn_r), .ped(db_ro));

    // CLOCK SET SECTION
    wire [1:0] hoursSel;
    wire [7:0] clkSetMin, clkSetHour;
    wire CsetTime;
    wire setMinSig = (showSet == 2'b01) & (hoursSel == 2'b00);
    wire setHourSig = (showSet == 2'b01) & (hoursSel == 2'b01);
    //wire setHourSig = ((hoursSel[0]==1'b1) && showSet[1]==1'b1);

    counter #(.BITS(2), .MAX_VAL(2)) setModeCount (.clk(clk), .rst(rst), .set(0), .c(db_co), .count(hoursSel), .zC(CsetTime));
    counterUpDown #(.BITS(6), .MAX_VAL(60)) cCSm (.clk(clk), .rst(rst), .c(setMinSig), .cu(db_uo), .cd(db_do), .count(clkSetMin));
    counterUpDown #(.BITS(5), .MAX_VAL(24)) cCSh (.clk(clk), .rst(rst), .c(setHourSig), .cu(db_uo), .cd(db_do), .count(clkSetHour));
    assign clkSet = {clkSetHour, clkSetMin};
    // END CLOCK SET SECTION

    
    // ALARM SET SECTION
    wire [1:0] AhoursSel;
    wire [7:0] AclkSetMin, AclkSetHour;
    wire AsetTime;
    wire AsetMinSig = (showSet == 2'b10) & (AhoursSel == 2'b00);
    wire AsetHourSig = (showSet == 2'b10) & (AhoursSel == 2'b01);
    wire soundAlarm = (clkAlarm == clkTime);

    counter #(.BITS(2), .MAX_VAL(2)) AsetModeCount (.clk(clk), .rst(rst), .set(0), .c(db_co), .count(AhoursSel), .zC(AsetTime));
    counterUpDown #(.BITS(6), .MAX_VAL(60)) AcCSm (.clk(clk), .rst(rst), .c(AsetMinSig), .cu(db_uo), .cd(db_do), .count(AclkSetMin));
    counterUpDown #(.BITS(5), .MAX_VAL(24)) AcCSh (.clk(clk), .rst(rst), .c(AsetHourSig), .cu(db_uo), .cd(db_do), .count(AclkSetHour));
    assign clkAlarm = {AclkSetHour, AclkSetMin};
    // END ALARM SET SECTION
    

    // CLOCK MODE SECTION
    counter #(.BITS(27), .MAX_VAL(100000000)) ct_i(.clk(clk), .rst(rst), .set(0), .c(sw), .zC(tickCount)); //counter each tick
    counter #(.BITS(6), .MAX_VAL(60)) cs_i(.clk(clk), .rst(rst), .c(tickCount), .set(0), .count(secCountNum[5:0]), .zC(secCount)); //counts seconds
    counter #(.BITS(6), .MAX_VAL(60)) cm_i(.clk(clk), .rst(rst), .c(secCount), .set(setTime), .countSet(clkSetMin), .count(minCountNum[5:0]), .zC(minCount)); //counts minutes
    counter #(.BITS(5), .MAX_VAL(24)) ch_i(.clk(clk), .rst(rst), .c(minCount), .set(setTime), .countSet(clkSetHour), .count(hourCountNum), .zC(hourCount)); //counts hours
    // END CLOCK MODE SECTION
    
    
    SevenSegmentDisplay sseg(.clk(clk), .rst(rst), .switches(ssegDisp), .cathode(cathode), .anode(anode));

    assign LED[1:0] = showSet;
    assign LED[3:2] = hoursSel;
    assign LED[4] = soundAlarm;
    assign anode[7:4] = 4'b1111;

endmodule