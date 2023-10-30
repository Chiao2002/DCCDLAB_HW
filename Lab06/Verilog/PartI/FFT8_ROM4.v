`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/10/26 16:21:34
// Design Name: 
// Module Name: FFT8_ROM4
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


module FFT8_ROM4 #(
    parameter W_WL=13
    )(
    output reg            valid_o,      //valid output
    output reg [W_WL-1:0] twiddle_real, //real part of twiddle factor
    output reg [W_WL-1:0] twiddle_imag, //imag part of twiddle factor
    input  [1:0] ctrl
    );
    localparam W_D8_U0=1'b0;            //W_4^0
    localparam W_D8_U1=1'b1;            //W_4^1

    wire  multi_state;                  //multi_state=0, 1 :W_4^(0:1)
    
    assign multi_state=ctrl[0];
    
    always @(multi_state)
        case(multi_state)
            W_D8_U0: begin
                twiddle_real= 13'd2048;
                twiddle_imag= 13'd0;
                valid_o=1;
                end
            W_D8_U1: begin
                twiddle_real= 13'd0;
                twiddle_imag=-13'd2048;
                valid_o=1;
                end

            default: begin
                twiddle_real= 13'd0;
                twiddle_imag= 13'd0;
                valid_o=0;
                end
        endcase
endmodule
