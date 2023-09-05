`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/12/21 22:59:58
// Design Name: 
// Module Name: bit_reverse_2
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
// finish stage 1

module bit_reverse_2(   clk,
                        rst,
                        in_real,
                        in_imag,
                        out_real,
                        out_imag);
    input clk, rst;
    input signed [16:0] in_real;    // 17 bits input
    input signed [16:0] in_imag;
    output signed [16:0] out_real; // 17 bits output
    output signed [16:0] out_imag;
    
    reg signed [16:0] reg_real [0:31];
    reg signed [16:0] reg_imag [0:31];
    
    reg [5:0] start;
    reg [5:0] counter;
    wire bitrev_en;
    
    assign bitrev_en = counter[5];
    
    always@(posedge clk or posedge rst) begin
        if(rst)
            start <= 6'd0;
        else
            start <= start + 6'd1;
    end
    
    always@(posedge clk) begin
        if(start == 6'd10)
            counter <= 6'd0;
        else
            counter <= counter + 6'd1;
    end
    
    always@(posedge clk or posedge rst) begin
        if(rst) begin
            reg_real[0] <= 17'd0;
            reg_real[1] <= 17'd0;
            reg_real[2] <= 17'd0;
            reg_real[3] <= 17'd0;
            reg_real[4] <= 17'd0;
            reg_real[5] <= 17'd0;
            reg_real[6] <= 17'd0;
            reg_real[7] <= 17'd0;
            reg_real[8] <= 17'd0;
            reg_real[9] <= 17'd0;
            reg_real[10] <= 17'd0;
            reg_real[11] <= 17'd0;
            reg_real[12] <= 17'd0;
            reg_real[13] <= 17'd0;
            reg_real[14] <= 17'd0;
            reg_real[15] <= 17'd0;
            reg_real[16] <= 17'd0;
            reg_real[17] <= 17'd0;
            reg_real[18] <= 17'd0;
            reg_real[19] <= 17'd0;
            reg_real[20] <= 17'd0;
            reg_real[21] <= 17'd0;
            reg_real[22] <= 17'd0;
            reg_real[23] <= 17'd0;
            reg_real[24] <= 17'd0;
            reg_real[25] <= 17'd0;
            reg_real[26] <= 17'd0;
            reg_real[27] <= 17'd0;
            reg_real[28] <= 17'd0;
            reg_real[29] <= 17'd0;
            reg_real[30] <= 17'd0;
            reg_real[31] <= 17'd0;
            
            reg_imag[0] <= 17'd0;
            reg_imag[1] <= 17'd0;
            reg_imag[2] <= 17'd0;
            reg_imag[3] <= 17'd0;
            reg_imag[4] <= 17'd0;
            reg_imag[5] <= 17'd0;
            reg_imag[6] <= 17'd0;
            reg_imag[7] <= 17'd0;
            reg_imag[8] <= 17'd0;
            reg_imag[9] <= 17'd0;
            reg_imag[10] <= 17'd0;
            reg_imag[11] <= 17'd0;
            reg_imag[12] <= 17'd0;
            reg_imag[13] <= 17'd0;
            reg_imag[14] <= 17'd0;
            reg_imag[15] <= 17'd0;
            reg_imag[16] <= 17'd0;
            reg_imag[17] <= 17'd0;
            reg_imag[18] <= 17'd0;
            reg_imag[19] <= 17'd0;
            reg_imag[20] <= 17'd0;
            reg_imag[21] <= 17'd0;
            reg_imag[22] <= 17'd0;
            reg_imag[23] <= 17'd0;
            reg_imag[24] <= 17'd0;
            reg_imag[25] <= 17'd0;
            reg_imag[26] <= 17'd0;
            reg_imag[27] <= 17'd0;
            reg_imag[28] <= 17'd0;
            reg_imag[29] <= 17'd0;
            reg_imag[30] <= 17'd0;
            reg_imag[31] <= 17'd0;
        end else if (bitrev_en) begin
            reg_real[{counter[0],counter[1],counter[2],counter[3],counter[4]}] <= in_real;
            reg_imag[{counter[0],counter[1],counter[2],counter[3],counter[4]}] <= in_imag;
        end
    end
    
    assign out_real = bitrev_en? 17'd0 : reg_real[counter[4:0]];
    assign out_imag = bitrev_en? 17'd0 : reg_imag[counter[4:0]];
    
endmodule
