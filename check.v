`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.10.2018 12:26:34
// Design Name: 
// Module Name: check
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
///////////////////////
module check(
input [1:0]number,
output reg [3:0] ones,
output reg [3:0] tens,
output reg [3:0] hundreds,
output reg [3:0] thousands,
output reg [2:0] led
);
always@(*)
begin
case(number)
    
    2'b01: begin   //pass
            ones<=4'd10;
            tens<=4'd10;
            hundreds<=4'd10;
            thousands<=4'd10;
            //led[0]<=1'b1;
            end
    2'b10:begin  //fail
                        ones<=4'd11;
                        tens<=4'd11;
                        hundreds<=4'd11;
                        thousands<=4'd11;
                        //led[1]<=1'b1;
                        end     
    2'b11: begin  //invalid
                                    ones<=4'd12;
                                    tens<=4'd12;
                                    hundreds<=4'd12;
                                    thousands<=4'd12;
                                    //led[2]<=1'b1;
                                    end
    default: begin
                                                ones<=4'd00;
                                                tens<=4'd00;
                                                hundreds<=4'd00;
                                                thousands<=4'd00;
                                                //led[0]<=1'b0;
                                                //led[1]<=1'b0;
                                                //led[2]<=1'b0;
                                              
                                                end                                
                                    
endcase
end                                    
endmodule
