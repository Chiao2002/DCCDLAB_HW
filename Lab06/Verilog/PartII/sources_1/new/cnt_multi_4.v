`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/19/2021 04:46:23 PM
// Design Name: 
// Module Name: cnt_multi_4
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


module cnt_multi_4(
                    clk,
                    rst,
                    en,
                    out_num
                    );
    input clk;
    input rst;
    input en;
    output signed [4:0] out_num;
    reg signed [4:0] out_num;
    
    always@(posedge clk) begin
        if (rst)
            out_num <= - 5'd9;
        else if (out_num == 5'd7 || en == 0)
            out_num <= 0;
        else
            out_num <= out_num + 5'd1;
    end
endmodule