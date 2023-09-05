`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/20/2021 09:47:42 PM
// Design Name: 
// Module Name: cnt_bitrev
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


module cnt_bitrev(
                    clk,
                    rst,
                    en,
                    out_num
                    );
    input clk;
    input rst;
    input en;
    output out_num;
    reg [6:0] out_num;
    
    always@(posedge clk) begin
        if (rst)

            out_num <= 7'd0;

        else
            out_num <= out_num + 7'd1;
    end
endmodule
