`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/12/13 13:21:52
// Design Name: 
// Module Name: dff2
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


module dff2( clk,
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
    
    reg signed [13:0] out_real;
    reg signed [13:0] out_imag;
    
    always@(posedge clk or posedge rst) begin
        if (rst == 1) begin
            out_real <= 0;
            out_imag <= 0;
        end else begin
            out_real <= in_real;
            out_imag <= in_imag;
        end
    end
endmodule
