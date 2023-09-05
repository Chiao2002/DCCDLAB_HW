`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/01/2021 02:13:26 PM
// Design Name: 
// Module Name: shift_and_add
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


module shift_and_add( scallingIN, scallingOUT );

    input signed [11:0] scallingIN;
    output wire signed [11:0] scallingOUT;
    
    wire signed [11:0] shiftR1;
    wire signed [11:0] shiftR3;
    wire signed [11:0] shiftR6;
    wire signed [11:0] shiftR9;
    wire signed [11:0] addOUT_1;
    wire signed [11:0] addOUT_2;
    wire signed [11:0] subOUT;
    
    assign shiftR1 = scallingIN >>> 1;
    assign shiftR3 = scallingIN >>> 3;
    assign shiftR6 = scallingIN >>> 6;
    assign shiftR9 = scallingIN >>> 9;
    
    adder add1(shiftR1, shiftR3, addOUT_1);
    adder add2(shiftR6, shiftR9, addOUT_2);
    subtractor sub3(addOUT_1, addOUT_2, subOUT);
    
    assign scallingOUT = subOUT;
endmodule
