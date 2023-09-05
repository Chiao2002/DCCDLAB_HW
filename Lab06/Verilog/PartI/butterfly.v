`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/12/10 17:52:12
// Design Name: 
// Module Name: butterfly
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


module butterfly( clk,
                  rst,
                  in_real,
                  in_imag,
                  out_real,
                  out_imag );
    input clk;
    input rst;
    input signed [14:0] in_real;
    input signed [14:0] in_imag;
    output signed [14:0] out_real;
    output signed [14:0] out_imag;
    integer counter;
    reg butterfly_en;
    reg signed [14:0] reg_real;
    reg signed [14:0] reg_imag;
    reg signed [16:0] out_real;
    reg signed [16:0] out_imag;
    
    always@(posedge clk or posedge rst) begin
        if (rst == 1) begin
            counter <= -2;
        end else if( counter == 1 || counter == 3 || counter == 5 || counter == 7 || counter == 9 || counter == 11 || counter == 13 || counter == 15 || counter == 17 || counter == 19 ) begin
            butterfly_en <= 1;
            counter <= counter + 1;
        end else begin
            butterfly_en <= 0;
            counter <= counter + 1;
        end
    end
   
    always@(posedge clk or posedge rst) begin
        if ( rst == 1 ) begin
            reg_real <= 0;
            reg_imag <= 0;
        end else if ( butterfly_en == 1 ) begin
            reg_real <= reg_real - in_real;
            reg_imag <= reg_imag - in_imag;
            out_real <= reg_real + in_real;
            out_imag <= reg_imag + in_imag;
            
        end else begin
            // bypass
            reg_real <= in_real;
            reg_imag <= in_imag;
            out_real <= reg_real;
            out_imag <= reg_imag;
            
        end
    end
endmodule
