`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module doorlock2(
input clk,
input clr,
input [3:0]in,
output reg [1:0] out,
//output reg [2:0] led,
  //decides the output if out==0; then PASS if out==1; then FAIl and if out==2; then INVALID
input enter,
input flagpress
);
//reg [3:0]ps=0;
reg [3:0] ps;
reg [3:0]ns;

parameter s0=4'b0000,s1=4'b0001,s2=4'b0010,s3=4'b0011,pass=4'b0101,f0=4'b0110,f1=4'b0111,f2=4'b1000, fail=4'b1001,inv=4'b1010,invhigh=4'b1011;
always @(posedge flagpress or posedge clr)
    begin
        if(clr)
        begin
            ps<=s0;
            //out<=2'b00;
        end 
        else
            ps<=ns;
    end

always @( *)
begin
    case(ps)
        s0:if(flagpress==1)
            begin
                if(in==4'hC)
                    ns<=s1;
                else
                    ns<=f0;
            end
          else if(enter)
            ns<=inv;
          else 
            ns<=s0;  
        s1:if(flagpress==1)
            begin
                if(in==4'hC)
                    ns<=s2;
                 else
                    ns<=f1;
             end          
           else if(enter)
            ns<=inv;
            else
            ns<=s1;
        s2:if(flagpress==1)
            begin
                if(in==4'hD)
                    ns<=s3;
                else
                ns<=f2;    
            end
            else if(enter)
                ns<=inv;
            else
                ns<=s2;
        s3: if(flagpress==1)
            begin
                ns<=invhigh;
            end
            
            else if(enter)
                ns<=pass;
            else
                ns<=s3;
        f0: if(flagpress==1)
            begin
                ns<=f1;
             end
            else if(enter)   
                ns<=inv;
            else
            ns<=f0;
        f1: if(flagpress==1)
            begin
                ns<=f2;
            end
            else if(enter)
            ns<=inv;
            else
            ns<=f1;
        f2:if(flagpress==1)
            begin
                ns<=invhigh;
            end
            else if(enter)
                ns<=fail;
            else
            ns<=f2;
            
        invhigh: if(flagpress==1)
                    begin
                        ns<=invhigh;
                     end   
                 else if(enter)
                   ns<=inv;
                 else
                   ns<=invhigh;
        pass: if(clr)
                ns<=s0;
              else
                ns<=pass;
        fail: if(clr)
                ns<=s0;
              else
                ns<=fail;
        inv: if(clr)
                ns<=s0;
              else
                ns<=inv;                                                              
        default : ns<=ns;
        endcase
        
        end
always @(*)
    begin
        if(ps==pass)
        begin
            out<=2'b01;
            //led[0]<=1'b1;
        end
        else if (ps==fail)
        begin
            out<=2'b10;
            //led[1]<=1'b1;
            end
        else if(ps==inv)
        begin
            out<=2'b11;
            //led[2]<=1'b1;
       end 
    end
                               
endmodule
