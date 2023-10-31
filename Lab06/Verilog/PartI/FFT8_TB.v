`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/10/22 15:45:54
// Design Name: 
// Module Name: FFT8_TB
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


module FFT8_TB();
    reg clk;                       //System clock
    reg rst_n;                     //Active low reset
    //declare for uFilein
    wire file_valid;
    wire [31:0] file_data;
    //declare for ufft8
    wire [11:0] idata_r;
    wire [11:0] idata_i;
    wire [17:0] odata_r;
    wire [17:0] odata_i;
    wire ovalid;
    
    assign idata_r=file_data[27:16];
    assign idata_i=file_data[11:0];
    
    TEXT_FILE_IN_AXI #(.DW(16), .FILE_NAME("fft8_testpattern.txt"))
    uFilein (
    .filein_count(),
    .m_axis_tdata(file_data),
    .m_axis_tvalid(file_valid),
    .m_axis_tready(1),
    .rst_n(rst_n),
    .clk(clk)
    );
     
    FFT8_DIF_RADIX2 #(.N(8), .DATA_IN_WL(12), .DATA_OUT_WL(18), .TWIDDLE_WL(13))
    uFFT8 (
    //input
    .valid_s(file_valid),
    .data_s_r(idata_r),
    .data_s_i(idata_i),
    //output
    .valid_m(ovalid),
    .data_m_r(odata_r),
    .data_m_i(odata_i),
    //
    .rst_n(rst_n),
    .clk(clk)
    );

    initial 
    begin
        clk=0;
        rst_n=0;
        #100 rst_n=1;
    end
    always #5 clk=~clk;
    
endmodule
