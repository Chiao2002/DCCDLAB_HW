`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/09/30 16:57:32
// Design Name: 
// Module Name: lab1_tb
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

/* Test bench */
module lab1_tb();
    reg CLK, RESET;
    wire y;
    
    lab1 uut(CLK, RESET, y);
    
    initial begin
        CLK = 0;
        RESET = 0;
        #15 RESET = 1;
        #500 RESET = 0;  
        #35 RESET = 1;   
    end
    always #5 CLK = ~CLK;
endmodule
