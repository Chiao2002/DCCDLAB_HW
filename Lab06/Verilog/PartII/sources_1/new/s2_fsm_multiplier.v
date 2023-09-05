`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/19/2021 12:26:12 PM
// Design Name: 
// Module Name: s2_fsm_multiplier
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


module s2_fsm_multiplier(
                            counter,
                            multi_in_real,
                            multi_in_imag,
                            multi_real,
                            multi_imag,
                            multi_real_imag_1,
                            multi_real_imag_2,
                            multi_stage
                          );
    input signed [4:0] counter;
    input signed [12:0] multi_in_real; // s0.12
    input signed [12:0] multi_in_imag;
    output signed [25:0] multi_real;
    output signed [25:0] multi_imag;
    output signed [25:0] multi_real_imag_1;
    output signed [25:0] multi_real_imag_2;
    output multi_stage;
    reg multi_stage;    
    reg signed [25:0] multi_real;
    reg signed [25:0] multi_imag;
    reg signed [25:0] multi_real_imag_1;
    reg signed [25:0] multi_real_imag_2;
    reg signed [12:0] twiddle_real;    // s1.11
    reg signed [12:0] twiddle_imag;
    reg out_mode;
    
    always@(*) begin
        // mode: 1 or 0
        // 1: Multiplication, 0: bypass operation
        case(counter)
            5'd0:begin
                out_mode = 1;
                twiddle_real =  13'd2048;
                twiddle_imag =  13'd0;
            end
            5'd1:begin
                out_mode = 1;
                twiddle_real =  13'd1892;
                twiddle_imag = -13'd784;
            end
            5'd2:begin
                out_mode = 1;
                twiddle_real =  13'd1448;
                twiddle_imag = -13'd1449;
            end
            5'd3:begin
                out_mode = 1;
                twiddle_real =  13'd783;
                twiddle_imag = -13'd1893;
            end
            5'd4:begin
                out_mode = 1;
                twiddle_real =  13'd0;
                twiddle_imag = -13'd2048;
            end
            5'd5:begin
                out_mode = 1;
                twiddle_real = -13'd784;
                twiddle_imag = -13'd1893;
            end
            5'd6:begin
                out_mode = 1;
                twiddle_real = -13'd1449;
                twiddle_imag = -13'd1449;
            end
            5'd7:begin
                out_mode = 1;
                twiddle_real = -13'd1893;
                twiddle_imag = -13'd784;
            end
            5'd8:begin
                out_mode = 0;
                twiddle_real =  13'd2048;
                twiddle_imag =  13'd0;
            end
            5'd9:begin
                out_mode = 0;
                twiddle_real =  13'd2048;
                twiddle_imag =  13'd0;
            end
            5'd10:begin
                out_mode = 0;
                twiddle_real =  13'd2048;
                twiddle_imag =  13'd0;
            end
            5'd11:begin
                out_mode = 0;
                twiddle_real =  13'd2048;
                twiddle_imag =  13'd0;
            end
            5'd12:begin
                out_mode = 0;
                twiddle_real =  13'd2048;
                twiddle_imag =  13'd0;
            end
            5'd13:begin
                out_mode = 0;
                twiddle_real =  13'd2048;
                twiddle_imag =  13'd0;
            end
            5'd14:begin
                out_mode = 0;
                twiddle_real =  13'd2048;
                twiddle_imag =  13'd0;
            end
            5'd15:begin
                out_mode = 0;
                twiddle_real =  13'd2048;
                twiddle_imag =  13'd0;
            end
            default:begin
                out_mode = 0;
                twiddle_real =  13'd2048;
                twiddle_imag =  13'd0;
            end
        endcase
    end
    always@(*)begin
        multi_stage <= out_mode;
        multi_real <= multi_in_real * twiddle_real;
        multi_imag <= multi_in_imag * twiddle_imag;
        multi_real_imag_1 <= multi_in_real * twiddle_imag;
        multi_real_imag_2 <= multi_in_imag * twiddle_real;
    end
endmodule
