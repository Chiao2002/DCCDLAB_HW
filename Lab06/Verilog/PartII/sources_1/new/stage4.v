`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/19/2021 04:46:23 PM
// Design Name: 
// Module Name: stage4
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


module stage4(
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
    input signed [14:0] in_real; // 15 bits input
    input signed [14:0] in_imag;
    output signed [14:0] out_real; // 15 bits output (before multi)
    output signed [14:0] out_imag;
    
    wire signed [4:0] counter;
    wire stage_mode;
    
    reg signed [14:0] out_real;
    reg signed [14:0] out_imag;
    // register
    reg signed [14:0] reg1_real;
    reg signed [14:0] reg1_imag;
    reg signed [14:0] reg2_real;
    reg signed [14:0] reg2_imag;
    
    wire signed [14:0] regIn_temp_real;
    wire signed [14:0] regIn_temp_imag;
    wire signed [14:0] regOut_temp_real;
    wire signed [14:0] regOut_temp_imag;
    wire signed [14:0] out_temp_real;
    wire signed [14:0] out_temp_imag;
    
    assign regIn_temp_real = reg1_real;
    assign regIn_temp_imag = reg1_imag;
    
    cnt_s4
    butterfly_cnt(
                    .clk(clk),
                    .rst(rst),
                    .en(cnt_en),
                    .out_num(counter)
                    );
    s4_fsm_butterfly
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
        end else begin
            reg1_real <= reg2_real;
            reg1_imag <= reg2_imag;
            reg2_real <= regOut_temp_real;
            reg2_imag <= regOut_temp_imag;
            out_real <= out_temp_real;
            out_imag <= out_temp_imag;
        end
    end
    
endmodule
