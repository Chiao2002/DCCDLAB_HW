`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/12/10 13:25:18
// Design Name: 
// Module Name: fft_8_sdf
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

//    stage3_butterfly_en,
module fft_8_sdf( clk,
                  rst,
                  in_real,
                  in_imag,
                  stage3_out_real,
                  stage3_out_imag );
    input clk;
    input rst;
    input signed [12:0] in_real;
    input signed [12:0] in_imag;
    output signed [15:0] stage3_out_real;
    output signed [15:0] stage3_out_imag;
    
    wire signed [12:0] s1_in_real;
    wire signed [12:0] s1_in_imag;
    wire signed [13:0] s2_in_real;
    wire signed [13:0] s2_in_imag;
    wire signed [12:0] stage1_out_real;
    wire signed [12:0] stage1_out_imag;

    wire signed [13:0] multi1_out_real;
    wire signed [13:0] multi1_out_imag;
    wire signed [13:0] stage2_out_real;
    wire signed [13:0] stage2_out_imag;
    wire signed [14:0] multi2_out_real;
    wire signed [14:0] multi2_out_imag;
    
    dff1 register1( .clk(clk),
                    .rst(rst),
                    .in_real(in_real),
                    .in_imag(in_imag),
                    .out_real(s1_in_real),
                    .out_imag(s1_in_imag) );
    butterfly_d4 stage1( .clk(clk),
                         .rst(rst),
                         .in_real(s1_in_real),
                         .in_imag(s1_in_imag),
                         .out_real(stage1_out_real),
                         .out_imag(stage1_out_imag) );
    multiplier M1( .clk(clk),
                   .rst(rst),
                   .multi_in_real(stage1_out_real),
                   .multi_in_imag(stage1_out_imag),
                   .multi_out_real(multi1_out_real),
                   .multi_out_imag(multi1_out_imag) );
    
    dff2 register2( .clk(clk),
                    .rst(rst),
                    .in_real(multi1_out_real),
                    .in_imag(multi1_out_imag),
                    .out_real(s2_in_real),
                    .out_imag(s2_in_imag) );
    butterfly_d2 stage2( .clk(clk),
                         .rst(rst),
                         .in_real(s2_in_real),
                         .in_imag(s2_in_imag),
                         .out_real(stage2_out_real),
                         .out_imag(stage2_out_imag) );
     multiplier2 M2( .clk(clk),
                     .rst(rst),
                     .multi_in_real(stage2_out_real),
                     .multi_in_imag(stage2_out_imag),
                     .multi_out_real(multi2_out_real),
                     .multi_out_imag(multi2_out_imag) );                    
                         
    butterfly    stage3( .clk(clk), 
                         .rst(rst),
                         .in_real(multi2_out_real),
                         .in_imag(multi2_out_imag),
                         .out_real(stage3_out_real),
                         .out_imag(stage3_out_imag) );

    

endmodule
