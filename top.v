`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module top(
input clk,
input clr,
input enter,
inout [7:0] JA,
output [7:0] cathode,
output [3:0] anode
//output [3:0] led
);        
wire [1:0] out;
wire [3:0] decodeout;
wire clk_190;
wire [3:0]ones;
wire [3:0]tens;
wire [3:0]hundreds;
wire [3:0]thousands;
wire clr1;
wire flagpress;
wire flag;
wire enter1;
wire [3:0] ps;
clk_pulse flag(.clk(clk_190),.deb_in(flag),.deb_out(flagpress));
clk_pulse flag(.clk(clk_190),.deb_in(enter1),.deb_out(enterpress));
clockdivid19 haha(.inclk(clk),.outclk(clk_190));
debouncer deb(.inclk(clk_190),.clr(enter),.outclk(enter1));
debouncer de(.inclk(clk_190),.clr(clr),.outclk(clr1));
Decoder dec(.clk(clk),.Row(JA[7:4]),.Col(JA[3:0]),.DecodeOut(decodeout),.flagfinal(flag));
doorlock2 dl(.clk(clk_190),.flagpress(flagpress),.clr(clr1),.enter(enterpress),.in(decodeout),.out(out));
check check(.number(out),.ones(ones),.tens(tens),.hundreds(hundreds),.thousands(thousands));
sevenseg_all sev(.clk(clk),.ones(ps),.tens(tens),.hundreds(hundreds),.thousands(thousands),.cathode(cathode),.anode(anode));
    
endmodule
