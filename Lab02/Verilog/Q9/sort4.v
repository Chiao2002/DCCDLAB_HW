`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/10/19 11:39:48
// Design Name: 
// Module Name: sort4
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


module sort4(
    input [10:0] data_in_1,
    input [10:0] data_in_2,
    input [10:0] data_in_3,
    input [10:0] data_in_4,
    output[10:0] data_out_1,
    output[10:0] data_out_2,
    output[10:0] data_out_3,
    output[10:0] data_out_4
    );
    wire [10:0] c1_min, c1_max;
    wire [10:0] c2_min, c2_max;
    wire [10:0] c3_max;
    wire [10:0] c4_min;
    
    cmp C1(.c1(data_in_1), .c2(data_in_2), .max(c1_max), .min(c1_min));
    cmp C2(.c1(data_in_3), .c2(data_in_4), .max(c2_max), .min(c2_min));
    cmp C3(.c1(c1_min), .c2(c2_min), .max(c3_max), .min(data_out_1));
    cmp C4(.c1(c1_max), .c2(c2_max), .max(data_out_4), .min(c4_min));
    cmp C5(.c1(c3_max), .c2(c4_min), .max(data_out_3), .min(data_out_2));
    
endmodule
