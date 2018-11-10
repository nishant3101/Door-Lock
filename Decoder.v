`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////////////////////////////
// Company: Digilent Inc 2011
// Engineer: Michelle Yu  
//				 Josh Sackos
// Create Date:    07/23/2012 
//
// Module Name:    Decoder
// Project Name:   PmodKYPD_Demo
// Target Devices: Nexys3
// Tool versions:  Xilinx ISE 14.1 
// Description: This file defines a component Decoder for the demo project PmodKYPD. The Decoder scans
//					 each column by asserting a low to the pin corresponding to the column at 1KHz. After a
//					 column is asserted low, each row pin is checked. When a row pin is detected to be low,
//					 the key that was pressed could be determined.
//
// Revision History: 
// 						Revision 0.01 - File Created (Michelle Yu)
//							Revision 0.02 - Converted from VHDL to Verilog (Josh Sackos)
//////////////////////////////////////////////////////////////////////////////////////////////////////////

// ==============================================================================================
// 												Define Module
// ==============================================================================================
module Decoder(
    clk,
    Row,
    Col,
    DecodeOut,
    
    detect,
    flagfinal
    );

// ==============================================================================================
// 											Port Declarations
// ==============================================================================================
    input clk;						// 100MHz onboard clock
    input [3:0] Row;				// Rows on KYPD
    output [3:0] Col;			// Columns on KYPD
    output [3:0] DecodeOut;	// Output data
    
    //output reg flag1;
    //output reg flag2;
    //output reg flag3;
    output flagfinal;
    output reg detect;
// ==============================================================================================
// 							  		Parameters, Regsiters, and Wires
// ==============================================================================================
	
	// Output wires and registers
	reg [3:0] Col;
	reg flag;
	reg flag1;
	reg flag2;
	reg flag3;
	reg [3:0] DecodeOut;
	
	// Count register
	reg [19:0] sclk;

// ==============================================================================================
// 												Implementation
// ==============================================================================================

	always @(posedge clk) begin

			// 1ms
			if (sclk == 20'b00011000011010100000) begin
				//C1
				Col <= 4'b0111;
				sclk <= sclk + 1'b1;
			end
			
			// check row pins
			else if(sclk == 20'b00011000011010101000) begin
				//R1
				if (Row == 4'b0111) begin
					DecodeOut <= 4'b0001;	
					flag<=1'b1;	//1
				end
				//R2
				else if(Row == 4'b1011) begin
					DecodeOut <= 4'b0100; 
					flag<=1'b1;		//4
				end
				//R3
				else if(Row == 4'b1101) begin
					DecodeOut <= 4'b0111; 
					flag<=1'b1;		//7
				end
				//R4
				else if(Row == 4'b1110) begin
					DecodeOut <= 4'b0000;
					flag<=1'b1; 		//0
				end
				else begin
                    flag<=1'b0;end
				sclk <= sclk + 1'b1;
				
			
			//flagfinal<=flag || flag1 || flag2 || flag3 ;
            end
			// 2ms
			else if(sclk == 20'b00110000110101000000) begin
				//C2
				Col<= 4'b1011;
				sclk <= sclk + 1'b1;
			end
			
			// check row pins
			else if(sclk == 20'b00110000110101001000) begin
				//R1
				if (Row == 4'b0111) begin
					DecodeOut <= 4'b0010; 
					flag1<=1'b1;		//2
				end
				//R2
				else if(Row == 4'b1011) begin
					DecodeOut <= 4'b0101; 
					flag1<=1'b1;		//5
				end
				//R3
				else if(Row == 4'b1101) begin
					DecodeOut <= 4'b1000;
					flag1<=1'b1; 		//8
				end
				//R4
				else if(Row == 4'b1110) begin
					DecodeOut <= 4'b1111;
					flag1<=1'b1; 		//F
				end
				
				else begin
				    flag1<=1'b0; end
				sclk <= sclk + 1'b1;   
				 //flagfinal<=flag || flag1 || flag2 || flag3;   
			end


			//3ms
			else if(sclk == 20'b01001001001111100000) begin
				//C3
				Col<= 4'b1101;
				sclk <= sclk + 1'b1;
			end
			
			// check row pins
			else if(sclk == 20'b01001001001111101000) begin
				//R1
				if(Row == 4'b0111) begin
					DecodeOut <= 4'b0011;
					flag2<=1'b1; 		//3	
				end
				//R2
				else if(Row == 4'b1011) begin
					DecodeOut <= 4'b0110;
					flag2<=1'b1; 		//6
				end
				//R3
				else if(Row == 4'b1101) begin
					DecodeOut <= 4'b1001;
					flag2<=1'b1; 		//9
				end
				//R4
				else if(Row == 4'b1110) begin
					DecodeOut <= 4'b1110;
					flag2<=1'b1; 		//E
				end
                else begin
                    flag2<=1'b0; end
				sclk <= sclk + 1'b1;
			//flagfinal<=flag || flag1 || flag2 || flag3;
			end
			

			//4ms
			else if(sclk == 20'b01100001101010000000) begin
				//C4
				Col<= 4'b1110;
				sclk <= sclk + 1'b1;
			end

			// Check row pins
			else if(sclk == 20'b01100001101010001000) begin
				//R1
				if(Row == 4'b0111) begin
					DecodeOut <= 4'b1010;
					flag3<=1'b1; //A
				end
				//R2
				else if(Row == 4'b1011) begin
					DecodeOut <= 4'b1011;
					flag3<=1'b1; //B
				end
				//R3
				else if(Row == 4'b1101) begin
					DecodeOut <= 4'b1100;
					flag3<=1'b1;
					//detect<=1'b1; //C
				end
				//R4
				else if(Row == 4'b1110) begin
					DecodeOut <= 4'b1101; //D
					flag3<=1'b1;
					//detect<=1'b1;
				end
				else  begin
				flag3<=1'b0; end
				    //flagfinal<=flag || flag1 || flag2 || flag3;
				sclk <= 20'b00000000000000000000;
				
			end

			// Otherwise increment
			else begin
				sclk <= sclk + 1'b1;
			end
			
	
    
end
assign flagfinal =flag || flag1 || flag2 || flag3;
endmodule
