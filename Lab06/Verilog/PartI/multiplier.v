`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/12/11 15:00:28
// Design Name: 
// Module Name: multiplier
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


module multiplier( clk,
                   rst,
                   multi_in_real,
                   multi_in_imag,
                   multi_out_real,
                   multi_out_imag );
    input clk;
    input rst;
    input signed [12:0] multi_in_real;
    input signed [12:0] multi_in_imag;
    output signed [13:0] multi_out_real;
    output signed [13:0] multi_out_imag;
    
    integer counter;
    reg signed [13:0] multi_out_real;
    reg signed [13:0] multi_out_imag;
    reg signed [25:0] multi_real;
    reg signed [25:0] multi_imag;
    reg signed [25:0] multi_real_imag_1;
    reg signed [25:0] multi_real_imag_2;
    wire signed [25:0] multi_out_real_26bit;
    wire signed [25:0] multi_out_imag_26bit;
 
    wire signed [12:0] twiddle_real_1;
    wire signed [12:0] twiddle_imag_1;
    wire signed [12:0] twiddle_real_2;
    wire signed [12:0] twiddle_imag_2;
    wire signed [12:0] twiddle_real_3;
    wire signed [12:0] twiddle_imag_3;
    wire signed [12:0] twiddle_real_4;
    wire signed [12:0] twiddle_imag_4;
    assign twiddle_real_1 = 13'd2048;
    assign twiddle_imag_1 = 13'd0;
    assign twiddle_real_2 = 13'd1448;
    assign twiddle_imag_2 = - 13'd1449;
    assign twiddle_real_3 = 13'd0;
    assign twiddle_imag_3 = - 13'd2048;
    assign twiddle_real_4 = - 13'd1449;
    assign twiddle_imag_4 = - 13'd1449;

    always@(posedge clk or posedge rst) begin
        if (rst == 1) begin
            multi_out_real <= 0;
            multi_out_imag <= 0;
        end else begin
        // truncation after multiplier 
        multi_out_real = multi_out_real_26bit[23:10];
        multi_out_imag = multi_out_imag_26bit[23:10];
        end
    end
    
    assign multi_out_real_26bit = multi_real - multi_imag;
    assign multi_out_imag_26bit = multi_real_imag_1 + multi_real_imag_2;


    always@(posedge clk or posedge rst) begin
        if (rst == 1) 
            counter <= -3;
        else if (counter == 8) begin
            multi_real <= multi_in_real * twiddle_real_1;
            multi_imag <= multi_in_imag * twiddle_imag_1;
            multi_real_imag_1 <= multi_in_real * twiddle_imag_1;
            multi_real_imag_2 <= multi_in_imag * twiddle_real_1;
            counter <= counter +1;
        end else if (counter == 9) begin
            multi_real <= multi_in_real * twiddle_real_2;
            multi_imag <= multi_in_imag * twiddle_imag_2;
            multi_real_imag_1 <= multi_in_real * twiddle_imag_2;
            multi_real_imag_2 <= multi_in_imag * twiddle_real_2;
            counter <= counter +1;
        end else if (counter == 10) begin
            multi_real <= multi_in_real * twiddle_real_3;
            multi_imag <= multi_in_imag * twiddle_imag_3;
            multi_real_imag_1 <= multi_in_real * twiddle_imag_3;
            multi_real_imag_2 <= multi_in_imag * twiddle_real_3;
            counter <= counter +1;
        end else if (counter == 11) begin
            multi_real <= multi_in_real * twiddle_real_4;
            multi_imag <= multi_in_imag * twiddle_imag_4;
            multi_real_imag_1 <= multi_in_real * twiddle_imag_4;
            multi_real_imag_2 <= multi_in_imag * twiddle_real_4;
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
