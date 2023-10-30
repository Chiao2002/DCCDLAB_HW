`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/10/26 23:55:07
// Design Name: 
// Module Name: FFT8_DIF_RADIX2
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


module FFT8_DIF_RADIX2 #(
    parameter N=8,
    parameter DATA_IN_WL=12,
    parameter DATA_IN_IWL=1,
    parameter DATA_OUT_WL=18,
    parameter TWIDDLE_WL=13
    )(
    //slave interface
    input                    valid_s,          //valid input
    input  [DATA_IN_WL-1:0]  data_s_r,         //real part of input
    input  [DATA_IN_WL-1:0]  data_s_i,         //imag part of input
    //master slave
    output                   valid_m,          //valid output
    output [DATA_OUT_WL-1:0] data_m_r,         //real part of output
    output [DATA_OUT_WL-1:0] data_m_i,         //imag part of output
    //
    input  rst_n,                              //Active low reset
    input  clk                                 //System clock
    );
    //declare stage 3
    localparam STAGE=$clog2(N);
    localparam ADDR_NO3_WIDTH=2;
    wire [TWIDDLE_WL-1:0] rom8_w_r;
    wire [TWIDDLE_WL-1:0] rom8_w_i;
    wire [STAGE-1:0]      ctrl_no3;
    wire [STAGE-1:0]      ctrl_no3_addr;
    wire                  valid_m_no3;
    wire                  en_multi_no3;

    //declare stage 2
    localparam STAGE2=$clog2(N>>1);
    localparam ADDR_NO2_WIDTH=1;
    localparam DATA_NO2_WL=14;
    localparam DATA_NO2_IWL=3;
    wire [DATA_NO2_WL-1:0] data_no2_r;
    wire [DATA_NO2_WL-1:0] data_no2_i;
    wire [TWIDDLE_WL-1:0]  rom4_w_r;
    wire [TWIDDLE_WL-1:0]  rom4_w_i;
    wire [STAGE2-1:0]      ctrl_no2;
    wire [STAGE2-1:0]      ctrl_no2_addr;
    wire                   valid_m_no2;
    wire                   en_multi_no2;
    
    //declare stage 1
    localparam STAGE1=$clog2(N>>2);
    localparam ADDR_NO1_WIDTH=1;
    localparam DATA_NO1_WL=16;
    localparam DATA_NO1_IWL=5;
    wire [DATA_NO1_WL-1:0] data_no1_r;
    wire [DATA_NO1_WL-1:0] data_no1_i;
    wire [STAGE1-1:0]      ctrl_no1;
    wire [STAGE1-1:0]      ctrl_no1_addr;
    wire                   en_multi_no1;
    

    ////////////
    //STAGE 3
    ////////////
    FFT8_STAGE #(.STAGE(STAGE), .ADDR_WIDTH(2), .W_WL(TWIDDLE_WL), .DATA_IN_WL(DATA_IN_WL), .DATA_IN_IWL(DATA_IN_IWL), .EXTN_WL(2))
    uStage3 ( 
    //slave interface
    .valid_s(valid_s),            //valid input
    .data_s_r(data_s_r),          //real part of input
    .data_s_i(data_s_i),          //imag part of input
    .twiddle_r(rom8_w_r),         //real part of twiddle factor
    .twiddle_i(rom8_w_i),         //imag part of twiddle factor
    //master interface
    .valid_m(valid_m_no3),        //valid output to stage2
    .data_m_r(data_no2_r),        //real part of output to stage2
    .data_m_i(data_no2_i),        //imag part of output to stage2
    //
    .ctrl(ctrl_no3),
    .addr(ctrl_no3_addr[ADDR_NO3_WIDTH-1:0]),
    .multi_state(en_multi_no3),
    .rst_n(rst_n),
    .clk(clk)
    );

    FFT8_ROM8 #(.W_WL(TWIDDLE_WL))
    uROM8 (
        .valid_o(en_multi_no3),
        .twiddle_real(rom8_w_r),
        .twiddle_imag(rom8_w_i),
        .ctrl(ctrl_no3)
    );

    Counter_Nbit #(.COUNT_WIDTH(STAGE))
    uCtrl_No3 (
        .count_up(ctrl_no3),
        .count_dwn(ctrl_no3_addr),
        .enable(valid_s),
        .rst_n(rst_n),
        .clk(clk)
    );
    
    ////////////
    //STAGE 2
    ////////////
    FFT8_STAGE #(.STAGE(STAGE2), .ADDR_WIDTH(ADDR_NO2_WIDTH), .W_WL(TWIDDLE_WL), .DATA_IN_WL(DATA_NO2_WL), .DATA_IN_IWL(DATA_NO2_IWL), .EXTN_WL(2))
    uStage2 ( 
    //slave interface
    .valid_s(valid_m_no3),        //valid input from stage3
    .data_s_r(data_no2_r),        //real part of input from stage3
    .data_s_i(data_no2_i),        //imag part of input from stage3
    .twiddle_r(rom4_w_r),         //real part of twiddle factor
    .twiddle_i(rom4_w_i),         //imag part of twiddle factor
    //master interface
    .valid_m(valid_m_no2),        //valid output to stage1
    .data_m_r(data_no1_r),        //real part of output to stage1
    .data_m_i(data_no1_i),        //imag part of output to stage1
    //
    .ctrl(ctrl_no2),
    .addr(ctrl_no2_addr),
    .multi_state(en_multi_no2),
    .rst_n(rst_n),
    .clk(clk)
    );
    
    FFT8_ROM4 #(.W_WL(TWIDDLE_WL))
    uROM4 (
        .valid_o(en_multi_no2),
        .twiddle_real(rom4_w_r),
        .twiddle_imag(rom4_w_i),
        .ctrl(ctrl_no2)
    );
    
    Counter_Nbit #(.COUNT_WIDTH(STAGE2))
    uCtrl_No2 (
        .count_up(ctrl_no2),
        .count_dwn(ctrl_no2_addr[ADDR_NO2_WIDTH-1:0]),
        .enable(valid_m_no3),
        .rst_n(rst_n),
        .clk(clk)
    );
    
    ////////////
    //STAGE 1
    ////////////
    FFT8_STAGE #(.STAGE(1), .ADDR_WIDTH(ADDR_NO1_WIDTH), .W_WL(TWIDDLE_WL), .DATA_IN_WL(DATA_NO1_WL), .DATA_IN_IWL(DATA_NO1_IWL), .EXTN_WL(2))
    uStage1 ( 
    //slave interface
    .valid_s(valid_m_no2),        //valid input from stage2
    .data_s_r(data_no1_r),        //real part of input from stage2
    .data_s_i(data_no1_i),        //imag part of input from stage2
    .twiddle_r(13'd2048),         //real part of twiddle factor
    .twiddle_i(13'd0),            //imag part of twiddle factor
    //master interface
    .valid_m(valid_m),            //valid output
    .data_m_r(data_m_r),          //real part of output
    .data_m_i(data_m_i),          //imag part of output
    //
    .ctrl(ctrl_no1),
    .addr(0),
    .multi_state(1),
    .rst_n(rst_n),
    .clk(clk)
    );
    
    Counter_Nbit #(.COUNT_WIDTH(STAGE1))
    uCtrl_No1 (
        .count_up(ctrl_no1),
        .count_dwn(),
        .enable(valid_m_no2),
        .rst_n(rst_n),
        .clk(clk)
    );
endmodule
