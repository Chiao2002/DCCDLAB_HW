`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/12/10 19:52:29
// Design Name: 
// Module Name: butterfly_d4
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


module butterfly_d4( clk,
                     rst,
                     in_real,
                     in_imag,
                     out_real,
                     out_imag );
    input clk;
    input rst;
    input signed [12:0] in_real;
    input signed [12:0] in_imag;
    output signed [12:0] out_real;
    output signed [12:0] out_imag;
    integer counter;
    reg signed [12:0] out_real;
    reg signed [12:0] out_imag;
    reg signed [12:0] reg1_real;
    reg signed [12:0] reg1_imag;
    reg signed [12:0] reg2_real;
    reg signed [12:0] reg2_imag;
    reg signed [12:0] reg3_real;
    reg signed [12:0] reg3_imag;
    reg signed [12:0] reg4_real;
    reg signed [12:0] reg4_imag;
    
   
    always@(posedge clk or posedge rst) begin
        if (rst == 1) begin
            reg1_real <= 0;
            reg1_imag <= 0;
            reg2_real <= 0;
            reg2_imag <= 0;
            reg3_real <= 0;
            reg3_imag <= 0;
            reg4_real <= 0;
            reg4_imag <= 0;
            counter <= -2;
        end else if ( counter == 4 || counter == 5 || counter == 6 || counter == 7 ) begin
            reg1_real <= reg2_real;
            reg1_imag <= reg2_imag;
            reg2_real <= reg3_real;
            reg2_imag <= reg3_imag;
            reg3_real <= reg4_real;
            reg3_imag <= reg4_imag;
            reg4_real <= reg1_real - in_real;
            reg4_imag <= reg1_imag - in_imag;
            out_real <= reg1_real + in_real;
            out_imag <= reg1_imag + in_imag;
            counter <= counter + 1;
        end else if ( counter == 12 || counter == 13 || counter == 14 || counter == 15 ) begin
            reg1_real <= reg2_real;
            reg1_imag <= reg2_imag;
            reg2_real <= reg3_real;
            reg2_imag <= reg3_imag;
            reg3_real <= reg4_real;
            reg3_imag <= reg4_imag;
            reg4_real <= reg1_real - in_real;
            reg4_imag <= reg1_imag - in_imag;
            out_real <= reg1_real + in_real;
            out_imag <= reg1_imag + in_imag;
            counter <= counter + 1;
        end else begin
            // bypass
            reg1_real <= reg2_real;
            reg1_imag <= reg2_imag;
            reg2_real <= reg3_real;
            reg2_imag <= reg3_imag;
            reg3_real <= reg4_real;
            reg3_imag <= reg4_imag;
            reg4_real <= in_real;
            reg4_imag <= in_imag;
            out_real <= reg1_real;
            out_imag <= reg1_imag;
            counter <= counter + 1;
        end
    end
endmodule
