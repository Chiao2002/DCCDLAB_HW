`timescale 1ns / 1ps

module cnt_s1( 
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
            out_num <= - 5'd2;
        else if (out_num == 5'd31 || en == 0)
            out_num <= 0;
        else
            out_num <= out_num + 5'd1;
    end
endmodule