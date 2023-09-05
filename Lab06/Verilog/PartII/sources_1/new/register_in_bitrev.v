`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/21/2021 04:47:32 PM
// Design Name: 
// Module Name: register_in_bitrev
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


module register_in_bitrev( 
                clk,
                rst,
                in_real,
                in_imag,
                out_real,
                out_imag
               );
    input clk;
    input rst;
    input signed [15:0] in_real; // 16 bits input
    input signed [15:0] in_imag;
    output signed [16:0] out_real; // 17 bits output
    output signed [16:0] out_imag; // s2.14
    
    reg signed [16:0] out_real;
    reg signed [16:0] out_imag;
    
    always@(posedge clk or posedge rst) begin
        if (rst == 1) begin
            out_real <= 17'd0;
            out_imag <= 17'd0;
        end else begin
            out_real <= in_real;
            out_imag <= in_imag;
        end
    end
endmodule