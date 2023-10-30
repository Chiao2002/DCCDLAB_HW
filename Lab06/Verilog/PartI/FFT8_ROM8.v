`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/10/22 14:59:44
// Design Name: 
// Module Name: FFT8_ROM8
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


module FFT8_ROM8 #(
    parameter W_WL=13
    )(
    output reg            valid_o,      //valid output
    output reg [W_WL-1:0] twiddle_real, //real part of twiddle factor
    output reg [W_WL-1:0] twiddle_imag, //imag part of twiddle factor
    input      [2:0]      ctrl
    );
    localparam W_D8_U0=2'b00;           //W_8^0
    localparam W_D8_U1=2'b01;           //W_8^1
    localparam W_D8_U2=2'b10;           //W_8^2
    localparam W_D8_U3=2'b11;           //W_8^3

    wire [1:0] multi_state;             //multi_state=0, 1, 2, 3 :W_8^(0:3)
    
    assign multi_state=ctrl[1:0];
    
    always @(multi_state)
        case(multi_state)
            W_D8_U0: begin
                twiddle_real= 13'd2048;
                twiddle_imag= 13'd0;
                valid_o=1;
                end
            W_D8_U1: begin
                twiddle_real= 13'd1448;
                twiddle_imag=-13'd1448;
                valid_o=1;
                end
            W_D8_U2: begin
                twiddle_real= 13'd0;
                twiddle_imag=-13'd2048;
                valid_o=1;
                end
            W_D8_U3: begin
                twiddle_real=-13'd1448;
                twiddle_imag=-13'd1448;
                valid_o=1;
                end
            default: begin
                twiddle_real= 13'd0;
                twiddle_imag= 13'd0;
                valid_o=0;
                end
        endcase
endmodule
