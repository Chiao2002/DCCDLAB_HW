`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/19/2021 04:46:23 PM
// Design Name: 
// Module Name: multiplier_s4
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


module multiplier_s4(
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
    input signed [14:0] multi_in_real;   // 15 bits input
    input signed [14:0] multi_in_imag;
    output signed [15:0] multi_out_real; // 16 bits output (after multi)
    output signed [15:0] multi_out_imag; // s1.14 (27 26 25 24. 23 22 ... => [25:10])
    
    reg signed [15:0] multi_out_real;
    reg signed [15:0] multi_out_imag;
    wire signed [4:0] counter;
    wire stage_mode;
    wire signed [27:0] multi_real;      //  s1.13 (in)
    wire signed [27:0] multi_imag;      //  s1.11 (twiddle)
    wire signed [27:0] multi_real_imag_1;// s3.24
    wire signed [27:0] multi_real_imag_2;
    wire signed [27:0] multi_out_real_28bit;
    wire signed [27:0] multi_out_imag_28bit;
    
    cnt_multi_4
    multi_cnt(
                .clk(clk),
                .rst(rst),
                .en(cnt_en),
                .out_num(counter)
                );
    s4_fsm_multiplier
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
            multi_out_real = multi_out_real_28bit[25:10];
            multi_out_imag = multi_out_imag_28bit[25:10];
        end
    end
    
    assign multi_out_real_28bit = multi_real - multi_imag;
    assign multi_out_imag_28bit = multi_real_imag_1 + multi_real_imag_2;
    
endmodule
