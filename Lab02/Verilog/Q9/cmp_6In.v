`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/10/19 14:15:12
// Design Name: 
// Module Name: cmp_6In
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


module cmp_6In(
    input [10:0] data_in_1,
    input [10:0] data_in_2,
    input [10:0] data_in_3,
    input [10:0] data_in_4,
    input [10:0] data_in_5,
    input [10:0] data_in_6,
    output [10:0] data_out_1,
    output [10:0] data_out_2,
    output [10:0] data_out_3
    );
    cmp C1(.c1(data_in_1), .c2(data_in_2), .min(data_out_1));
    cmp C2(.c1(data_in_3), .c2(data_in_4), .min(data_out_2));
    cmp C3(.c1(data_in_5), .c2(data_in_6), .min(data_out_3));     
endmodule
