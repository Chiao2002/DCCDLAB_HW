`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/10/26 16:20:12
// Design Name: 
// Module Name: Counter_Nbit
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


module Counter_Nbit #(
    parameter COUNT_WIDTH=3
    )(
    output reg [COUNT_WIDTH-1:0] count_up,
    output reg [COUNT_WIDTH-1:0] count_dwn,
    input  enable,
    input  rst_n,
    input  clk
    );
    //count up
    always @(posedge clk or negedge rst_n)
        if(~rst_n) begin
            count_up<=0;
        end
        else begin 
            if(enable) begin
                count_up<=count_up+1;
            end
            else begin
                count_up<=count_up;
            end
        end
        
    //count down
    always @(posedge clk or negedge rst_n)
        if(~rst_n) begin
            count_dwn<=(1'b1<<COUNT_WIDTH)-1;
        end
        else begin
            if(enable) begin
                count_dwn<=count_dwn-1;
            end
            else begin
                count_dwn<=count_dwn;
            end
        end
        
endmodule
