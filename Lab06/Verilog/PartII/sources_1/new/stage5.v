`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/20/2021 11:44:30 AM
// Design Name: 
// Module Name: stage5
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


module stage5(
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
    input signed [15:0] in_real; // 16 bits input
    input signed [15:0] in_imag;
    output signed [15:0] out_real; // 16 bits output (before multi)
    output signed [15:0] out_imag;
    
    wire signed [4:0] counter;
    wire stage_mode;
    
    reg signed [15:0] out_real;
    reg signed [15:0] out_imag;
    // register
    reg signed [15:0] reg1_real;
    reg signed [15:0] reg1_imag;
    
    wire signed [15:0] regIn_temp_real;
    wire signed [15:0] regIn_temp_imag;
    wire signed [15:0] regOut_temp_real;
    wire signed [15:0] regOut_temp_imag;
    wire signed [15:0] out_temp_real;
    wire signed [15:0] out_temp_imag;
    
    assign regIn_temp_real = reg1_real;
    assign regIn_temp_imag = reg1_imag;
    
    cnt_s5
    butterfly_cnt(
                    .clk(clk),
                    .rst(rst),
                    .en(cnt_en),
                    .out_num(counter)
                    );
    s5_fsm_butterfly
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
        end else begin
            reg1_real <= regOut_temp_real;
            reg1_imag <= regOut_temp_imag;
            out_real <= out_temp_real;
            out_imag <= out_temp_imag;
        end
    end
    
endmodule
