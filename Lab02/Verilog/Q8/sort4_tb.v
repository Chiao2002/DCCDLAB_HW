`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/10/19 11:41:21
// Design Name: 
// Module Name: sort4_tb
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


module sort4_tb();
    reg [10:0] data_in [0:3];
    wire [10:0] data_out [0:3];
    wire signed [5:0] data_value[0:3];
    wire signed [4:0] data_index[0:3];
    assign data_value[0] = data_out[0][10:5];
    assign data_value[1] = data_out[1][10:5];
    assign data_value[2] = data_out[2][10:5];
    assign data_value[3] = data_out[3][10:5];
    assign data_index[0] = data_out[0][4:0];
    assign data_index[1] = data_out[1][4:0];
    assign data_index[2] = data_out[2][4:0];
    assign data_index[3] = data_out[3][4:0];
    
    sort4 S1(
    .data_in_1(data_in[0]),
    .data_in_2(data_in[1]),
    .data_in_3(data_in[2]),
    .data_in_4(data_in[3]),
    .data_out_1(data_out[0]),
    .data_out_2(data_out[1]),
    .data_out_3(data_out[2]),
    .data_out_4(data_out[3])
    );
    initial begin
        data_in[0][10:5] = 6'd4; data_in[0][4:0] = 5'd1;
        data_in[1][10:5] = -6'd2; data_in[1][4:0] = 5'd2;
        data_in[2][10:5] = -6'd32; data_in[2][4:0] = 5'd3;
        data_in[3][10:5] = -6'd11; data_in[3][4:0] = 5'd4;
         #100 $stop;
    end
endmodule
