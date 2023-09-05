`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/20/2021 11:44:30 AM
// Design Name: 
// Module Name: multiplier_s5
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


module multiplier_s5(
                       clk,
                       rst,
                       cnt_en,
                       multi_in_real,
                       multi_in_imag,
                       multi_out_real,
                       multi_out_imag
                       );
    input clk;
    input rst;
    input cnt_en;
    input signed [15:0] multi_in_real;   // 16 bits input
    input signed [15:0] multi_in_imag;
    output signed [16:0] multi_out_real; // 17 bits output (after multi)
    output signed [16:0] multi_out_imag; // s0.16 (28 27 26. 25 24 23 22 ... => [26:10])
    
    reg signed [16:0] multi_out_real;
    reg signed [16:0] multi_out_imag;
    wire signed [4:0] counter;
    wire stage_mode;
    wire signed [28:0] multi_real;      //  s0.15 (in)
    wire signed [28:0] multi_imag;      //  s1.11 (twiddle)
    wire signed [28:0] multi_real_imag_1;// s2.26
    wire signed [28:0] multi_real_imag_2;
    wire signed [28:0] multi_out_real_29bit;
    wire signed [28:0] multi_out_imag_29bit;
    
    cnt_multi_5
    multi_cnt(
                .clk(clk),
                .rst(rst),
                .en(cnt_en),
                .out_num(counter)
                );
    s5_fsm_multiplier
    multi_operation(
                     .counter(counter),
                     .multi_in_real(multi_in_real),
                     .multi_in_imag(multi_in_imag),
                     .multi_real(multi_real),
                     .multi_imag(multi_imag),
                     .multi_real_imag_1(multi_real_imag_1),
                     .multi_real_imag_2(multi_real_imag_2),
                     .multi_stage(stage_mode)
                     );
    
    always@(posedge clk or posedge rst) begin
        if (rst == 1) begin
            multi_out_real <= 0;
            multi_out_imag <= 0;
        end else begin
            // truncation after multiplier 
            multi_out_real = multi_out_real_29bit[26:10];
            multi_out_imag = multi_out_imag_29bit[26:10];
        end
    end
    
    assign multi_out_real_29bit = multi_real - multi_imag;
    assign multi_out_imag_29bit = multi_real_imag_1 + multi_real_imag_2;
    
endmodule
