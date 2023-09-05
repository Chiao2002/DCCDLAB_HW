`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/19/2021 01:48:45 AM
// Design Name: 
// Module Name: fft_32_point
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


module fft_32_point(
                     clk,
                     rst,
                     cnt_en,
                     in_real,
                     in_imag,
                     out_real,
                     out_imag
                     );
    input clk, rst;
    input cnt_en;
    input signed [11:0] in_real;  // 12 bits input
    input signed [11:0] in_imag;
    output signed [16:0] out_real;// 17 bits output after S5
    output signed [16:0] out_imag;
    
    reg signed [16:0] out_real;// 17 bits output after S5
    reg signed [16:0] out_imag;
    
    reg signed [11:0] s1_in_real;
    reg signed [11:0] s1_in_imag;
    wire signed [11:0] s1_out_real;
    wire signed [11:0] s1_out_imag;
    wire signed [12:0] s2_in_real;
    wire signed [12:0] s2_in_imag;
    wire signed [12:0] s2_out_real;
    wire signed [12:0] s2_out_imag;
    wire signed [13:0] s3_in_real;
    wire signed [13:0] s3_in_imag;
    wire signed [13:0] s3_out_real;
    wire signed [13:0] s3_out_imag;
    wire signed [14:0] s4_in_real;
    wire signed [14:0] s4_in_imag;
    wire signed [14:0] s4_out_real;
    wire signed [14:0] s4_out_imag;
    wire signed [15:0] s5_in_real;
    wire signed [15:0] s5_in_imag;
    wire signed [15:0] s5_out_real;
    wire signed [15:0] s5_out_imag;
    wire signed [16:0] register_in_real;
    wire signed [16:0] register_in_imag;
    wire signed [16:0] bitrev_in_real;
    wire signed [16:0] bitrev_in_imag;
    wire signed [16:0] bitrev_out_real;
    wire signed [16:0] bitrev_out_imag;
    
//    dff_in
//    register_In( 
//                .clk(clk),
//                .rst(rst),
//                .in_real(in_real),
//                .in_imag(in_imag),
//                .out_real(s1_in_real),
//                .out_imag(s1_in_imag)
//                );

    always@(posedge clk) begin
        if(rst) begin
            s1_in_real <= 0;
            s1_in_imag <= 0;
        end else begin
            s1_in_real <= in_real;
            s1_in_imag <= in_imag;
        end
    end
    
    stage1
    S1(
               .clk(clk),
               .rst(rst),
               .cnt_en(cnt_en),
               .in_real(s1_in_real),
               .in_imag(s1_in_imag),
               .out_real(s1_out_real),
               .out_imag(s1_out_imag)
               );
    multiplier_s1
    M1(
               .clk(clk),
               .rst(rst),
               .cnt_en(cnt_en),
               .multi_in_real(s1_out_real),
               .multi_in_imag(s1_out_imag),
               .multi_out_real(s2_in_real),
               .multi_out_imag(s2_in_imag)
               );
    stage2
    S2(
               .clk(clk),
               .rst(rst),
               .cnt_en(cnt_en),
               .in_real(s2_in_real),
               .in_imag(s2_in_imag),
               .out_real(s2_out_real),
               .out_imag(s2_out_imag)
               );
    multiplier_s2
    M2(
               .clk(clk),
               .rst(rst),
               .cnt_en(cnt_en),
               .multi_in_real(s2_out_real),
               .multi_in_imag(s2_out_imag),
               .multi_out_real(s3_in_real),
               .multi_out_imag(s3_in_imag)
               );
    
    stage3
    S3(
               .clk(clk),
               .rst(rst),
               .cnt_en(cnt_en),
               .in_real(s3_in_real),
               .in_imag(s3_in_imag),
               .out_real(s3_out_real),
               .out_imag(s3_out_imag)
               );
    multiplier_s3
    M3(
               .clk(clk),
               .rst(rst),
               .cnt_en(cnt_en),
               .multi_in_real(s3_out_real),
               .multi_in_imag(s3_out_imag),
               .multi_out_real(s4_in_real),
               .multi_out_imag(s4_in_imag)
               );
    
    stage4
    S4(
               .clk(clk),
               .rst(rst),
               .cnt_en(cnt_en),
               .in_real(s4_in_real),
               .in_imag(s4_in_imag),
               .out_real(s4_out_real),
               .out_imag(s4_out_imag)
               );
    multiplier_s4
    M4(
               .clk(clk),
               .rst(rst),
               .cnt_en(cnt_en),
               .multi_in_real(s4_out_real),
               .multi_in_imag(s4_out_imag),
               .multi_out_real(s5_in_real),
               .multi_out_imag(s5_in_imag)
               );
    
    stage5
    S5(
               .clk(clk),
               .rst(rst),
               .cnt_en(cnt_en),
               .in_real(s5_in_real),
               .in_imag(s5_in_imag),
//               .out_real(out_real),
//               .out_imag(out_imag)
               .out_real(s5_out_real),
               .out_imag(s5_out_imag)
               );
//    multiplier_s5
//    M5(
//               .clk(clk),
//               .rst(rst),
//               .cnt_en(cnt_en),
//               .multi_in_real(s5_out_real),
//               .multi_in_imag(s5_out_imag),
////               .multi_out_real(register_in_real),
////               .multi_out_imag(register_in_imag)
//               .multi_out_real(bitrev_in_real),
//               .multi_out_imag(bitrev_in_imag)
////               .multi_out_real(out_real),
////               .multi_out_imag(out_imag)
//               );
    register_in_bitrev
    in_bitrev( 
                .clk(clk),
                .rst(rst),
                .in_real(s5_out_real),
                .in_imag(s5_out_imag),
                .out_real(bitrev_in_real),
                .out_imag(bitrev_in_imag)
//                .out_real(out_real),
//                .out_imag(out_imag)
               );
               
//    bit_reverse
//    B ( 
//            .clk(clk),
//            .rst(rst),
//            .en(cnt_en),
//            .in_real(bitrev_in_real),
//            .in_imag(bitrev_in_imag),
//            .out_real(out_real),
//            .out_imag(out_imag)
//            );
    bit_reverse_2
    B2 (    .clk(clk),
            .rst(rst),
            .in_real(bitrev_in_real),
            .in_imag(bitrev_in_imag),
            .out_real(bitrev_out_real),
            .out_imag(bitrev_out_imag)
            );
            
    always@(posedge clk) begin
        if(rst) begin
            out_real <= 0;
            out_imag <= 0;
        end else begin
            out_real <= bitrev_out_real;
            out_imag <= bitrev_out_imag;
        end

    end
endmodule
