`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/19/2021 12:26:12 PM
// Design Name: 
// Module Name: stage2
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


module stage2(
                clk,
                rst,
                cnt_en,
                in_real,
                in_imag,
                out_real,
                out_imag
               );
    input clk;
    input rst;
    input cnt_en;
    input signed [12:0] in_real; // 13 bits input
    input signed [12:0] in_imag;
    output signed [12:0] out_real; // 13 bits output (before multi)
    output signed [12:0] out_imag;
    
    wire signed [4:0] counter;
    wire stage_mode;
    
    reg signed [12:0] out_real;
    reg signed [12:0] out_imag;
    // register
    reg signed [12:0] reg1_real;
    reg signed [12:0] reg1_imag;
    reg signed [12:0] reg2_real;
    reg signed [12:0] reg2_imag;
    reg signed [12:0] reg3_real;
    reg signed [12:0] reg3_imag;
    reg signed [12:0] reg4_real;
    reg signed [12:0] reg4_imag;
    reg signed [12:0] reg5_real;
    reg signed [12:0] reg5_imag;
    reg signed [12:0] reg6_real;
    reg signed [12:0] reg6_imag;
    reg signed [12:0] reg7_real;
    reg signed [12:0] reg7_imag;
    reg signed [12:0] reg8_real;
    reg signed [12:0] reg8_imag;
    
    wire signed [12:0] regIn_temp_real;
    wire signed [12:0] regIn_temp_imag;
    wire signed [12:0] regOut_temp_real;
    wire signed [12:0] regOut_temp_imag;
    wire signed [12:0] out_temp_real;
    wire signed [12:0] out_temp_imag;
    
    assign regIn_temp_real = reg1_real;
    assign regIn_temp_imag = reg1_imag;
    
    cnt_s2
    butterfly_cnt(
                    .clk(clk),
                    .rst(rst),
                    .en(cnt_en),
                    .out_num(counter)
                    );
    s2_fsm_butterfly
    butterfly_mode(
                    .counter(counter),
                    .in_real(in_real),
                    .in_imag(in_imag),
                    .regIn_real(regIn_temp_real),
                    .regIn_imag(regIn_temp_imag),
                    .regOut_real(regOut_temp_real),
                    .regOut_imag(regOut_temp_imag),
                    .out_real(out_temp_real),
                    .out_imag(out_temp_imag),
                    .butterfly_stage(stage_mode)
                    );
    
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
            reg5_real <= 0;
            reg5_imag <= 0;
            reg6_real <= 0;
            reg6_imag <= 0;
            reg7_real <= 0;
            reg7_imag <= 0;
            reg8_real <= 0;
            reg8_imag <= 0;
        end else begin
            reg1_real <= reg2_real;
            reg1_imag <= reg2_imag;
            reg2_real <= reg3_real;
            reg2_imag <= reg3_imag;
            reg3_real <= reg4_real;
            reg3_imag <= reg4_imag;
            reg4_real <= reg5_real;
            reg4_imag <= reg5_imag;
            reg5_real <= reg6_real;
            reg5_imag <= reg6_imag;
            reg6_real <= reg7_real;
            reg6_imag <= reg7_imag;
            reg7_real <= reg8_real;
            reg7_imag <= reg8_imag;
            reg8_real <= regOut_temp_real;
            reg8_imag <= regOut_temp_imag;
            out_real <= out_temp_real;
            out_imag <= out_temp_imag;
        end
    end
    
endmodule
