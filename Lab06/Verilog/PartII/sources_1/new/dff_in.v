`timescale 1ns / 1ps

module dff_in( 
                clk,
                rst,
                in_real,
                in_imag,
                out_real,
                out_imag
               );
    input clk;
    input rst;
    input signed [11:0] in_real; // 12 bits input
    input signed [11:0] in_imag;
    output signed [11:0] out_real; // 12 bits output
    output signed [11:0] out_imag;
    
    reg signed [11:0] out_real;
    reg signed [11:0] out_imag;
    
    always@(posedge clk or posedge rst) begin
        if (rst == 1) begin
            out_real <= 12'd0;
            out_imag <= 12'd0;
        end else begin
            out_real <= in_real;
            out_imag <= in_imag;
        end
    end
endmodule