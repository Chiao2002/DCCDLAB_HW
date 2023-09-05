`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/12/12 15:13:20
// Design Name: 
// Module Name: multiplier2
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


module multiplier2( clk,
                    rst,
                    multi_in_real,
                    multi_in_imag,
                    multi_out_real,
                    multi_out_imag );
    input clk;
    input rst;
    input signed [13:0] multi_in_real;
    input signed [13:0] multi_in_imag;
    output signed [14:0] multi_out_real;
    output signed [14:0] multi_out_imag;
    
    integer counter;
    reg signed [14:0] multi_out_real;
    reg signed [14:0] multi_out_imag;
    reg signed [27:0] multi_real;
    reg signed [27:0] multi_imag;
    reg signed [27:0] multi_real_imag_1;
    reg signed [27:0] multi_real_imag_2;
    wire signed [27:0] multi_out_real_28bit;
    wire signed [27:0] multi_out_imag_28bit;
 
    wire signed [13:0] twiddle_real_1;
    wire signed [13:0] twiddle_imag_1;
    wire signed [13:0] twiddle_real_2;
    wire signed [13:0] twiddle_imag_2;
    assign twiddle_real_1 = 14'd4096;
    assign twiddle_imag_1 = 14'd0;
    assign twiddle_real_2 = 14'd0;
    assign twiddle_imag_2 = - 14'd4096;
    
    always@(posedge clk or posedge rst) begin
        if (rst == 1) begin
            multi_out_real <= 0;
            multi_out_imag <= 0;
        end else begin
            // truncation after multiplier 
            multi_out_real = multi_out_real_28bit[25:11];
            multi_out_imag = multi_out_imag_28bit[25:11];
        end
    end
    
    assign multi_out_real_28bit = multi_real - multi_imag;
    assign multi_out_imag_28bit = multi_real_imag_1 + multi_real_imag_2;


    always@(posedge clk or posedge rst) begin
        if (rst == 1) 
            counter <= -3;
        else if (counter == 12 || counter == 16) begin
            multi_real <= multi_in_real * twiddle_real_1;
            multi_imag <= multi_in_imag * twiddle_imag_1;
            multi_real_imag_1 <= multi_in_real * twiddle_imag_1;
            multi_real_imag_2 <= multi_in_imag * twiddle_real_1;
            counter <= counter +1;
        end else if (counter == 13 || counter == 17) begin
            multi_real <= multi_in_real * twiddle_real_2;
            multi_imag <= multi_in_imag * twiddle_imag_2;
            multi_real_imag_1 <= multi_in_real * twiddle_imag_2;
            multi_real_imag_2 <= multi_in_imag * twiddle_real_2;
            counter <= counter +1;
        end else begin
            multi_real <= multi_in_real * twiddle_real_1;
            multi_imag <= multi_in_imag * twiddle_imag_1;
            multi_real_imag_1 <= multi_in_real * twiddle_imag_1;
            multi_real_imag_2 <= multi_in_imag * twiddle_real_1;
            counter <= counter +1;
        end
    end
                   
endmodule
