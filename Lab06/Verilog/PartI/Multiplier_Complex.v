`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/10/22 21:49:09
// Design Name: 
// Module Name: Multiplier_Complex
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


module Multiplier_Complex #(
    parameter W_WL=13,            //wordlength of twiddle factor [S1.11]
    parameter DATA_WL=14,         //wordlength of input data  [S2.11]
    parameter DATA_IWL=3,         //wordlength of integer part of input data
    parameter WL=14,              //wordlength of output data [S2.11]
    parameter IWL=3               //wordlength of integer part of output data
    )( 
    input  signed [DATA_WL-1:0] data_s_r, //real  part of input (slave) :a
    input  signed [DATA_WL-1:0] data_s_i, //imag  part of input (slave) :b
    input  signed [W_WL-1:0] w_r,         //real  part of twiddle factor:c
    input  signed [W_WL-1:0] w_i,         //imag  part of twiddle factor:d
    output signed [WL-1:0] data_m_r,      //real  part of output (master)
    output signed [WL-1:0] data_m_i,      //imag  part of output (master)
    input  rst_n,
    input  clk
    );
    reg [DATA_WL+W_WL-1:0] multi_ac, multi_bd, multi_ad, multi_bc;
    wire signed [DATA_WL+W_WL:0] multi_r;
    wire signed [DATA_WL+W_WL:0] multi_i;
    
    /* (a+j*b)*(c+j*d)=(a*c-b*d)+j*(a*d+b*c) */
//    assign multi_ac=data_s_r*w_r;
//    assign multi_bd=data_s_i*w_i;
//    assign multi_ad=data_s_r*w_i;
//    assign multi_bc=data_s_i*w_r;
    always @(posedge clk or negedge rst_n)
        if(~rst_n) begin
            multi_ac <= 0;
            multi_bd <= 0;
            multi_ad <= 0;
            multi_bc <= 0;
        end
        else begin
            multi_ac <= data_s_r*w_r;
            multi_bd <= data_s_i*w_i;
            multi_ad <= data_s_r*w_i;
            multi_bc <= data_s_i*w_r;
        end
    
    //sign extented than +/- them together
    assign multi_r={multi_ac[DATA_WL+W_WL-1], multi_ac}-{multi_bd[DATA_WL+W_WL-1], multi_bd};
    assign multi_i={multi_ad[DATA_WL+W_WL-1], multi_ad}+{multi_bc[DATA_WL+W_WL-1], multi_bc};
    
    //assign the output
    assign data_m_r=multi_r>>>(WL-IWL);
    assign data_m_i=multi_i>>>(WL-IWL);
    
endmodule

/* complex multiplier (pseudocode)
    input  signed [WL-1:0] In_r, In_i;
    input  signed [W_WL-1:0] W_r, W_i;
    output signed [WL-1:0] Out_r, Out_i;
    parameter WL=13, W_WL=13;
    wire signed [WL+W_WL-1:0] multi_r, multi_i;
    // (a+j*b)*(c+j*d)=(a*c-b*d)+j*(a*d+b*c)
    assign multi_r=In_r*W_r-In_i*W_i;
    assign multi_i=In_r*W_i+In_i*W_r;
    //S1.11*S1.11=>S3.22 [25 24 23 22. 21 ...0]
    assign Out_r={multi_r[25], multi_r[22:11]};
    assign Out_i={multi_i[25], multi_i[22:11]};
*/