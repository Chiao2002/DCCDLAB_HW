`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/19/2021 11:14:10 AM
// Design Name: 
// Module Name: multiplier_s1
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


module multiplier_s1(
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
    input signed [11:0] multi_in_real;   // 12 bits input
    input signed [11:0] multi_in_imag;
    output signed [12:0] multi_out_real; // 13 bits output (after multi)
    output signed [12:0] multi_out_imag; // s1.11 (24 23 22. 21 ... => [23:11])
    
    reg signed [13:0] multi_out_real;
    reg signed [13:0] multi_out_imag;
    wire signed [4:0] counter;
    wire stage_mode;
    wire signed [24:0] multi_real;      //  s0.11 (in)
    wire signed [24:0] multi_imag;      //  s1.11 (twiddle)
    wire signed [24:0] multi_real_imag_1;// s2.22
    wire signed [24:0] multi_real_imag_2;
    wire signed [24:0] multi_out_real_25bit;
    wire signed [24:0] multi_out_imag_25bit;
    
    cnt_multi_1
    multi_cnt(
                .clk(clk),
                .rst(rst),
                .en(cnt_en),
                .out_num(counter)
                );
    
    s1_fsm_multiplier
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
            multi_out_real = multi_out_real_25bit[23:11];
            multi_out_imag = multi_out_imag_25bit[23:11];
        end
    end
    
    assign multi_out_real_25bit = multi_real - multi_imag;
    assign multi_out_imag_25bit = multi_real_imag_1 + multi_real_imag_2;
    
endmodule
