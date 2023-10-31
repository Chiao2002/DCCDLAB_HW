`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/10/31 20:37:27
// Design Name: 
// Module Name: TEXT_FILE_IN_AXI
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


module TEXT_FILE_IN_AXI #(
    parameter DW = 16,
              FILE_NAME = "TP_MATLAB_IN.txt" //The delimiter for file paths should be "/".
    )(
    output [15:0]     filein_count,
    output [2*DW-1:0] m_axis_tdata,
    output            m_axis_tvalid,
    input             m_axis_tready,
    input             rst_n,                 //Active low reset
    input             clk                    //System clock
    );
    localparam data_width = 16;
    localparam total_data_sz = 4000000;
    integer fp_r, cnt, c;
    integer sel;
    wire filein_out_en;
    wire filein_out_read;
    reg [DW-1:0] filein_out_data1;
    reg [DW-1:0] filein_out_data2;
    reg [data_width-1:0] data1 [0:total_data_sz-1]; 
    reg [data_width-1:0] data2 [0:total_data_sz-1];
    
    assign m_axis_tdata = {filein_out_data1, filein_out_data2};
    assign m_axis_tvalid = filein_out_en;
    assign filein_count = sel;

    assign filein_out_read = m_axis_tvalid & m_axis_tready;
    assign filein_out_en = rst_n & (sel < (c-1));
    
    always @(posedge clk or negedge rst_n)
        if (~rst_n) begin
           sel <= 0;
           filein_out_data1 <= data1[0];
           filein_out_data2 <= data2[0];
        end
        else begin        
            if (filein_out_read) begin
                sel <= sel + 1;
                filein_out_data1 <= data1[sel+1];
                filein_out_data2 <= data2[sel+1];
            end
        end
    
    //File Read
    initial
    begin
        fp_r = $fopen(FILE_NAME, "r");
        c = 0;
        if (fp_r==0) begin
            $display("The file open is failed.");
        end
        else begin
            while(!$feof(fp_r)) begin
                cnt = $fscanf(fp_r, "%d	%d", data1[c], data2[c]);
                c = c+1;
            end
            $fclose(fp_r);
        end
    end

endmodule
