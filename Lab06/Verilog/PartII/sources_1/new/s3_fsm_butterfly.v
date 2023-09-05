`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/19/2021 03:45:41 PM
// Design Name: 
// Module Name: s3_fsm_butterfly
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


module s3_fsm_butterfly(
                         counter,
                         in_real,
                         in_imag,
                         regIn_real,
                         regIn_imag,
                         regOut_real,
                         regOut_imag,
                         out_real,
                         out_imag,
                         butterfly_stage
                         );
    input signed [4:0] counter;                      
    input signed [13:0] in_real;  // 14 bits input of S3
    input signed [13:0] in_imag;
    input signed [13:0] regIn_real;
    input signed [13:0] regIn_imag;
    output signed [13:0] regOut_real;
    output signed [13:0] regOut_imag;
    output signed [13:0] out_real;// 14 bits output
    output signed [13:0] out_imag;
    output butterfly_stage;

    reg signed [13:0] reg_temp_real;
    reg signed [13:0] reg_temp_imag;
    reg signed [13:0] out_temp_real;
    reg signed [13:0] out_temp_imag;
    reg out_mode;
    
    always@(*) begin
        // mode: 1 or 0
        // 1: Butterfly, 0: bypass operation
        case(counter)
            5'd0:begin
                out_mode = 0;
                reg_temp_real = in_real;
                reg_temp_imag = in_imag;
                out_temp_real = regIn_real;
                out_temp_imag = regIn_imag;
            end
            5'd1:begin
                out_mode = 0;
                reg_temp_real = in_real;
                reg_temp_imag = in_imag;
                out_temp_real = regIn_real;
                out_temp_imag = regIn_imag;
            end
            5'd2:begin
                out_mode = 0;
                reg_temp_real = in_real;
                reg_temp_imag = in_imag;
                out_temp_real = regIn_real;
                out_temp_imag = regIn_imag;
            end
            5'd3:begin
                out_mode = 0;
                reg_temp_real = in_real;
                reg_temp_imag = in_imag;
                out_temp_real = regIn_real;
                out_temp_imag = regIn_imag;
            end
            5'd4:begin
                out_mode = 1;
                reg_temp_real = regIn_real - in_real;
                reg_temp_imag = regIn_imag - in_imag;
                out_temp_real = regIn_real + in_real;
                out_temp_imag = regIn_imag + in_imag;
            end
            5'd5:begin
                out_mode = 1;
                reg_temp_real = regIn_real - in_real;
                reg_temp_imag = regIn_imag - in_imag;
                out_temp_real = regIn_real + in_real;
                out_temp_imag = regIn_imag + in_imag;
            end
            5'd6:begin
                out_mode = 1;
                reg_temp_real = regIn_real - in_real;
                reg_temp_imag = regIn_imag - in_imag;
                out_temp_real = regIn_real + in_real;
                out_temp_imag = regIn_imag + in_imag;
            end
            5'd7:begin
                out_mode = 1;
                reg_temp_real = regIn_real - in_real;
                reg_temp_imag = regIn_imag - in_imag;
                out_temp_real = regIn_real + in_real;
                out_temp_imag = regIn_imag + in_imag;
            end
            default:begin
                out_mode = 0;
                reg_temp_real = in_real;
                reg_temp_imag = in_imag;
                out_temp_real = regIn_real;
                out_temp_imag = regIn_imag;
            end
        endcase
    end

    assign    butterfly_stage = out_mode;
    assign    out_real = out_temp_real;
    assign    out_imag = out_temp_imag;
    assign    regOut_real = reg_temp_real;
    assign    regOut_imag = reg_temp_imag;
    
endmodule
