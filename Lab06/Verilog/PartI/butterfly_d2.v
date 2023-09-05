`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/12/10 19:47:12
// Design Name: 
// Module Name: butterfly_d2
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


module butterfly_d2( clk,
                     rst,
                     in_real,
                     in_imag,
                     out_real,
                     out_imag );
    input clk;
    input rst;
    input signed [13:0] in_real;
    input signed [13:0] in_imag;
    output signed [13:0] out_real;
    output signed [13:0] out_imag;
    integer counter;
    reg signed [13:0] out_real;
    reg signed [13:0] out_imag;
    reg signed [13:0] reg1_real;
    reg signed [13:0] reg1_imag;
    reg signed [13:0] reg2_real;
    reg signed [13:0] reg2_imag;
    
   
    always@(posedge clk or posedge rst) begin
        if (rst == 1) begin
            reg1_real <= 0;
            reg1_imag <= 0;
            reg2_real <= 0;
            reg2_imag <= 0;
            counter <= -3;
        end else if ( counter == 9 || counter == 10 ) begin
            reg1_real <= reg2_real;
            reg1_imag <= reg2_imag;
            reg2_real <= reg1_real - in_real;
            reg2_imag <= reg1_imag - in_imag;
            out_real <= reg1_real + in_real;
            out_imag <= reg1_imag + in_imag;
            counter <= counter + 1;
        end else if ( counter == 13 || counter == 14 ) begin 
           reg1_real <= reg2_real;
            reg1_imag <= reg2_imag;
            reg2_real <= reg1_real - in_real;
            reg2_imag <= reg1_imag - in_imag;
            out_real <= reg1_real + in_real;
            out_imag <= reg1_imag + in_imag;
            counter <= counter + 1;
        end else if ( counter == 17 || counter == 18 ) begin 
           reg1_real <= reg2_real;
            reg1_imag <= reg2_imag;
            reg2_real <= reg1_real - in_real;
            reg2_imag <= reg1_imag - in_imag;
            out_real <= reg1_real + in_real;
            out_imag <= reg1_imag + in_imag;
            counter <= counter + 1;
        end else begin
            reg1_real <= reg2_real;
            reg1_imag <= reg2_imag;
            reg2_real <= in_real;
            reg2_imag <= in_imag;
            out_real <= reg1_real;
            out_imag <= reg1_imag;
            counter <= counter + 1;
        end
    end
endmodule
