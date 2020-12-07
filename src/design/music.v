// Music demo verilog file
// (c) fpga4fun.com 2003-2015

// Plays a little tune on a speaker
// Use a 25MHz clock if possible (other frequencies will 
// change the pitch/speed of the song)

/////////////////////////////////////////////////////
module music(
	input clk, alarm,
	input [1:0] sel,
	output reg speaker
);

reg [32:0] tone;
always @(posedge clk) tone <= tone+33'd1;

wire [7:0] fullnote;

songs get_fullnote1(.clk(clk), .address(tone[31:24]), .note(fullnote),.sel(sel),.alarm(alarm));

wire [2:0] octave;
wire [3:0] note;

divide_by12 get_octave_and_note(.numerator(fullnote[5:0]), .quotient(octave), .remainder(note));

reg [8:0] clkdivider;
always @*
case(note)
	 0: clkdivider = 9'd511;//A
	 1: clkdivider = 9'd482;// A#/Bb
	 2: clkdivider = 9'd455;//B
	 3: clkdivider = 9'd430;//C
	 4: clkdivider = 9'd405;// C#/Db
	 5: clkdivider = 9'd383;//D
	 6: clkdivider = 9'd361;// D#/Eb
	 7: clkdivider = 9'd341;//E
	 8: clkdivider = 9'd322;//F
	 9: clkdivider = 9'd303;// F#/Gb
	10: clkdivider = 9'd286;//G
	11: clkdivider = 9'd270;// G#/Ab
	default: clkdivider = 9'd0;
endcase

reg [8:0] counter_note;
reg [7:0] counter_octave;
always @(posedge clk) counter_note <= counter_note==0 ? clkdivider : counter_note-9'd1;
always @(posedge clk) if(counter_note==0) counter_octave <= counter_octave==0 ? 8'd255 >> octave : counter_octave-8'd1;
always @(posedge clk) if(counter_note==0 && counter_octave==0 && fullnote!=0 && tone[23:20]!=0) speaker <= ~speaker;
endmodule


/////////////////////////////////////////////////////
module divide_by12(
	input [5:0] numerator,  // value to be divided by 12
	output reg [2:0] quotient, 
	output [3:0] remainder
);

reg [1:0] remainder3to2;
always @(numerator[5:2])
case(numerator[5:2])
	 0: begin quotient=0; remainder3to2=0; end
	 1: begin quotient=0; remainder3to2=1; end
	 2: begin quotient=0; remainder3to2=2; end
	 3: begin quotient=1; remainder3to2=0; end
	 4: begin quotient=1; remainder3to2=1; end
	 5: begin quotient=1; remainder3to2=2; end
	 6: begin quotient=2; remainder3to2=0; end
	 7: begin quotient=2; remainder3to2=1; end
	 8: begin quotient=2; remainder3to2=2; end
	 9: begin quotient=3; remainder3to2=0; end
	10: begin quotient=3; remainder3to2=1; end
	11: begin quotient=3; remainder3to2=2; end
	12: begin quotient=4; remainder3to2=0; end
	13: begin quotient=4; remainder3to2=1; end
	14: begin quotient=4; remainder3to2=2; end
	15: begin quotient=5; remainder3to2=0; end
endcase

assign remainder[1:0] = numerator[1:0];  // the first 2 bits are copied through
assign remainder[3:2] = remainder3to2;  // and the last 2 bits come from the case statement
endmodule

/////////////////////////////////////////////////////

module songs(
	input clk, alarm,
	input [7:0] address,
	input [1:0] sel,
	output reg [7:0] note
);

wire song2address = address  [6:0];
wire song3address = address  [4:0];

always @(posedge clk)
if(sel == 2'b00 && alarm) begin
case(address)
	  0: note<= 8'd25; //G
	  1: note<= 8'd27; //A //A
	  2: note<= 8'd27; //A //A
	  3: note<= 8'd25; //G
	  4: note<= 8'd22; //E //E
	  5: note<= 8'd22; //E //E
	  6: note<= 8'd30; //C //C
	  7: note<= 8'd30; //C //C
	  8: note<= 8'd27; //A
	  9: note<= 8'd27; //A
	 10: note<= 8'd25; //G
	 11: note<= 8'd25; //G
	 12: note<= 8'd25; //G
	 13: note<= 8'd25; //G
	 14: note<= 8'd25; //G
	 15: note<= 8'd25; //G
	 16: note<= 8'd25; //G
	 17: note<= 8'd27; //A
	 18: note<= 8'd25; //G
	 19: note<= 8'd27; //A
	 20: note<= 8'd25; //G
	 21: note<= 8'd25; //G
	 22: note<= 8'd30; //C
	 23: note<= 8'd30; //C
	 24: note<= 8'd29; //B 
	 25: note<= 8'd29; //B
	 26: note<= 8'd29; //B
	 27: note<= 8'd29; //B
	 28: note<= 8'd29; //B
	 29: note<= 8'd29; //B
	 30: note<= 8'd29; //B
	 31: note<= 8'd29; //B
	 32: note<= 8'd23; //F
	 33: note<= 8'd25; //G
	 34: note<= 8'd25; //G
	 35: note<= 8'd23; //F
	 36: note<= 8'd20; //D 
	 37: note<= 8'd20; //D
	 38: note<= 8'd29; //B 
	 39: note<= 8'd29; //B
	 40: note<= 8'd27; //A
	 41: note<= 8'd27; //A
	 42: note<= 8'd25; //G
	 43: note<= 8'd25; //G
	 44: note<= 8'd25; //G
	 45: note<= 8'd25; //G
	 46: note<= 8'd25; //G
	 47: note<= 8'd25; //G
	 48: note<= 8'd25; //G
	 49: note<= 8'd27; //A
	 50: note<= 8'd25; //G
	 51: note<= 8'd27; //A
	 52: note<= 8'd25; //G
	 53: note<= 8'd25; //G
	 54: note<= 8'd27; //A
	 55: note<= 8'd27; //A
	 56: note<= 8'd22; //E
	 57: note<= 8'd22; //E
	 58: note<= 8'd22; //E
	 59: note<= 8'd22; //E
	 60: note<= 8'd22; //E
	 61: note<= 8'd22; //E
	 62: note<= 8'd22; //E
	 63: note<= 8'd22; //E
	 64: note<= 8'd25; //G
	 65: note<= 8'd27; //A
	 66: note<= 8'd27; //A
	 67: note<= 8'd25; //G
	 68: note<= 8'd22; //E
	 69: note<= 8'd22; //E
	 70: note<= 8'd30; //C
	 71: note<= 8'd30; //C
	 72: note<= 8'd27; //A
	 73: note<= 8'd27; //A
	 74: note<= 8'd25; //G
	 75: note<= 8'd25; //G
	 76: note<= 8'd25; //G
	 77: note<= 8'd25; //G
	 78: note<= 8'd25; //G
	 79: note<= 8'd25; //G
	 80: note<= 8'd25; //G
	 81: note<= 8'd27; //A
	 82: note<= 8'd25; //G
	 83: note<= 8'd27; //A
	 84: note<= 8'd25; //G
	 85: note<= 8'd25; //G
	 86: note<= 8'd30; //C
	 87: note<= 8'd30; //C
	 88: note<= 8'd29; //B
	 89: note<= 8'd29; //B
	 90: note<= 8'd29; //B
	 91: note<= 8'd29; //B
	 92: note<= 8'd29; //B
	 93: note<= 8'd29; //B
	 94: note<= 8'd29; //B
	 95: note<= 8'd29; //B
	 96: note<= 8'd23; //F
	 97: note<= 8'd25; //G
	 98: note<= 8'd25; //G
	 99: note<= 8'd23; //F
	100: note<= 8'd20; //D
	101: note<= 8'd20; //D
	102: note<= 8'd29; //B
	103: note<= 8'd29; //B
	104: note<= 8'd27; //A
	105: note<= 8'd27; //A
	106: note<= 8'd25; //G
	107: note<= 8'd25; //G
	108: note<= 8'd25; //G
	109: note<= 8'd25; //G
	110: note<= 8'd25; //G
	111: note<= 8'd25; //G
	112: note<= 8'd25; //G
	113: note<= 8'd27; //A
	114: note<= 8'd25; //G
	115: note<= 8'd27; //A
	116: note<= 8'd25; //G
	117: note<= 8'd25; //G
	118: note<= 8'd32; //D
	119: note<= 8'd32; //D
	120: note<= 8'd30; //C
	121: note<= 8'd30; //C
	122: note<= 8'd30; //C
	123: note<= 8'd30; //C
	124: note<= 8'd30; //C
	125: note<= 8'd30; //C
	126: note<= 8'd30; //C
	127: note<= 8'd30; //C
	128: note<= 8'd27; //A
	129: note<= 8'd27; //A
	130: note<= 8'd27; //A
	131: note<= 8'd27; //A
	132: note<= 8'd30; //C
	133: note<= 8'd30; //C
	134: note<= 8'd30; //C
	135: note<= 8'd27; //A
	136: note<= 8'd25; //G
	137: note<= 8'd25; //G
	138: note<= 8'd22; //E
	139: note<= 8'd22; //E
	140: note<= 8'd25; //G
	141: note<= 8'd25; //G
	142: note<= 8'd25; //G
	143: note<= 8'd25; //G
	144: note<= 8'd23; //F
	145: note<= 8'd23; //F
	146: note<= 8'd27; //A
	147: note<= 8'd27; //A
	148: note<= 8'd25; //G
	149: note<= 8'd25; //G
	150: note<= 8'd23; //F
	151: note<= 8'd23; //F
	152: note<= 8'd22; //E
	153: note<= 8'd22; //E
	154: note<= 8'd22; //E
	155: note<= 8'd22; //E
	156: note<= 8'd22; //E
	157: note<= 8'd22; //E
	158: note<= 8'd22; //E
	159: note<= 8'd22; //E
	160: note<= 8'd20; //D
	161: note<= 8'd20; //D
	162: note<= 8'd22; //E
	163: note<= 8'd22; //E
	164: note<= 8'd25; //G
	165: note<= 8'd25; //G
	166: note<= 8'd27; //A
	167: note<= 8'd27; //A
	168: note<= 8'd29; //B
	169: note<= 8'd29; //B
	170: note<= 8'd29; //B
	171: note<= 8'd29; //B
	172: note<= 8'd29; //B
	173: note<= 8'd29; //B
	174: note<= 8'd29; //B
	175: note<= 8'd29; //B
	176: note<= 8'd30; //C
	177: note<= 8'd30; //C
	178: note<= 8'd30; //C
	179: note<= 8'd30; //C
	180: note<= 8'd29; //B
	181: note<= 8'd29; //B
	182: note<= 8'd27; //A
	183: note<= 8'd27; //A
	184: note<= 8'd25; //G
	185: note<= 8'd25; //G
	186: note<= 8'd23; //F
	187: note<= 8'd20; //D
	188: note<= 8'd20; //D
	189: note<= 8'd20; //D
	190: note<= 8'd20; //D
	191: note<= 8'd20; //D
	192: note<= 8'd25; //G
	193: note<= 8'd27; //A
	194: note<= 8'd27; //A
	195: note<= 8'd25; //G
	196: note<= 8'd22; //E
	197: note<= 8'd22; //E
	198: note<= 8'd30; //C
	199: note<= 8'd30; //C
	200: note<= 8'd27; //A
	201: note<= 8'd27; //A
	202: note<= 8'd25; //G
	203: note<= 8'd25; //G
	204: note<= 8'd25; //G
	205: note<= 8'd25; //G
	206: note<= 8'd25; //G
	207: note<= 8'd25; //G
	208: note<= 8'd25; //G
	209: note<= 8'd27; //A
	210: note<= 8'd25; //G
	211: note<= 8'd27; //A
	212: note<= 8'd25; //G
	213: note<= 8'd25; //G
	214: note<= 8'd30; //C
	215: note<= 8'd30; //C
	216: note<= 8'd29; //B
	217: note<= 8'd29; //B
	218: note<= 8'd29; //B
	219: note<= 8'd29; //B
	220: note<= 8'd29; //B
	221: note<= 8'd29; //B
	222: note<= 8'd29; //B
	223: note<= 8'd29; //B
	224: note<= 8'd23; //F
	225: note<= 8'd25; //G
	226: note<= 8'd25; //G
	227: note<= 8'd23; //F
	228: note<= 8'd20; //D
	229: note<= 8'd20; //D
	230: note<= 8'd29; //B
	231: note<= 8'd29; //B
	232: note<= 8'd27; //A
	233: note<= 8'd27; //A
	234: note<= 8'd25; //G
	235: note<= 8'd25; //G
	236: note<= 8'd25; //G
	237: note<= 8'd25; //G
	238: note<= 8'd25; //G
	239: note<= 8'd25; //G
	240: note<= 8'd25; //G
	241: note<= 8'd0;
	242: note<= 8'd00;
	default: note <= 8'd0;
endcase
end
else if(sel == 2'b10 && alarm) begin
    case(song2address)
        0 : note<= 8'd22; //E 
        1 : note<= 8'd22; //E 
        2 : note<= 8'd22; //E 
        3 : note<= 8'd22; //E 
        4 : note<= 8'd22; //E 
        5 : note<= 8'd22; //E 
        6 : note<= 8'd0; 
        7 : note<= 8'd0; 
        8 : note<= 8'd22; //E 
        9 : note<= 8'd22; //E 
        10 : note<= 8'd22; //E 
        11 : note<= 8'd22; //E 
        12 : note<= 8'd22; //E 
        13 : note<= 8'd22; //E 
        14 : note<= 8'd0; 
        15 : note<= 8'd0; 
        16 : note<= 8'd22; //E 
        17 : note<= 8'd22; //E 
        18 : note<= 8'd25; //G 
        19 : note<= 8'd25; //G 
        20 : note<= 8'd30; //C 
        21 : note<= 8'd30; //C 
        22 : note<= 8'd20; //D 
        23 : note<= 8'd20; //D 
        24 : note<= 8'd22; //E 
        25 : note<= 8'd22; //E 
        26 : note<= 8'd0; 
        27 : note<= 8'd0; 
        28 : note<= 8'd0; 
        29 : note<= 8'd0; 
        30 : note<= 8'd0; 
        31 : note<= 8'd0; 
        32 : note<= 8'd23; //D //2ND LINE OF SONG
        33 : note<= 8'd23; //D 
        34 : note<= 8'd23; //D 
        35 : note<= 8'd23; //D 
        36 : note<= 8'd23; //D 
        37 : note<= 8'd23; //D 
        38 : note<= 8'd23; //D 
        39 : note<= 8'd23; //D 
        40 : note<= 8'd23; //D 
        41 : note<= 8'd23; //D 
        42 : note<= 8'd22; //E 
        43 : note<= 8'd22; //E 
        44 : note<= 8'd22; //E 
        45 : note<= 8'd22; //E 
        46 : note<= 8'd22; //E 
        47 : note<= 8'd22; //E 
        48 : note<= 8'd22; //E //3RD LINE OF SONG
        49 : note<= 8'd22; //E 
        50 : note<= 8'd20; //D 
        51 : note<= 8'd20; //D 
        52 : note<= 8'd20; //D 
        53 : note<= 8'd20; //D 
        54 : note<= 8'd22; //E 
        55 : note<= 8'd22; //E 
        56 : note<= 8'd20; //D 
        57 : note<= 8'd0; 
        58 : note<= 8'd25; //G 
        59 : note<= 8'd0; 
        60 : note<= 8'd22; //E //4th LINE OF SONG
        61 : note<= 8'd22; //E 
        62 : note<= 8'd22; //E 
        63 : note<= 8'd22; //E 
        64 : note<= 8'd22; //E 
        65 : note<= 8'd22; //E 
        66 : note<= 8'd0; 
        67 : note<= 8'd0; 
        68 : note<= 8'd22; //E 
        69 : note<= 8'd22; //E 
        70 : note<= 8'd22; //E 
        71 : note<= 8'd22; //E 
        72 : note<= 8'd22; //E 
        73 : note<= 8'd22; //E 
        74 : note<= 8'd0; 
        75 : note<= 8'd0; 
        76 : note<= 8'd22; //E 
        77 : note<= 8'd22; //E 
        78 : note<= 8'd25; //G 
        79 : note<= 8'd25; //G 
        80 : note<= 8'd30; //C 
        81 : note<= 8'd30; //C 
        82 : note<= 8'd20; //D 
        83 : note<= 8'd20; //D 
        84 : note<= 8'd22; //E 
        85 : note<= 8'd22; //E 
        86 : note<= 8'd0; 
        87 : note<= 8'd0; 
        88 : note<= 8'd0; 
        89 : note<= 8'd0; 
        90 : note<= 8'd0; 
        91 : note<= 8'd0; 
        92 : note<= 8'd23; //D //F //5TH LINE OF SONG 
        93 : note<= 8'd23; //D 
        94 : note<= 8'd23; //D 
        95 : note<= 8'd23; //D 
        96 : note<= 8'd23; //D 
        97 : note<= 8'd23; //D 
        98 : note<= 8'd23; //D 
        99 : note<= 8'd23; //D 
        100 : note<= 8'd23; //D
        101 : note<= 8'd23; //D 
        102 : note<= 8'd22; //E 
        103 : note<= 8'd22; //E 
        104 : note<= 8'd22; //E 
        105 : note<= 8'd22; //E 
        106 : note<= 8'd22; //E 
        107 : note<= 8'd22; //E 
        108 : note<= 8'd25; //G  //6th LINE of SONG
        109 : note<= 8'd25; //G 
        110 : note<= 8'd25; //G 
        111 : note<= 8'd25; //G 
        112 : note<= 8'd23; //D 
        113 : note<= 8'd23; //D 
        114 : note<= 8'd20; //D 
        115 : note<= 8'd20; //D 
        116 : note<= 8'd30; //C 
        117 : note<= 8'd30; //C 
        default: note <= 8'd0;
    endcase
end

else if(sel == 2'b10 && alarm) begin
    case(song3address)
        0 : note<= 8'd22; //E 
        1 : note<= 8'd22; //E 
        2 : note<= 8'd22; //E 
        3 : note<= 8'd22; //E 
        4 : note<= 8'd22; //E 
        5 : note<= 8'd22; //E 
        6 : note<= 8'd0; 
        7 : note<= 8'd0; 
        8 : note<= 8'd22; //E 
        9 : note<= 8'd22; //E 
        10 : note<= 8'd22; //E 
        11 : note<= 8'd22; //E 
        12 : note<= 8'd22; //E 
        13 : note<= 8'd22; //E 
        14 : note<= 8'd0; 
        15 : note<= 8'd0; 
        16 : note<= 8'd22; //E 
        17 : note<= 8'd22; //E 
        18 : note<= 8'd25; //G 
        19 : note<= 8'd25; //G 
        default: note <= 8'd0;
    endcase
end

else begin
    case(song3address)
        default: note<= 8'd0;
    endcase
end
endmodule
