`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/09/30 22:00:24
// Design Name: 
// Module Name: lab1
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
/* M-sequence */
/* Input:
    clk - The clock for the LFSR
    rst - Active-high reset of the LFSR
 * Output:
    out - The output of the LFSR
*/
module lab1(
    input clk, rst,
    output out
    );
    /* Declare shift register variables. */
    reg [3:0] sreg;
    wire out;
    /* Always block infers active-hign reset of the initial state */
    always@(posedge clk) begin
        if(!rst) begin
            sreg[3] <= 1;
            sreg[2] <= 0;
            sreg[1] <= 0;
            sreg[0] <= 0;
        end
        /* Shift registers */
        else begin
            sreg[3] <= sreg[0];
            sreg[2] <= sreg[3];
            sreg[1] <= sreg[2];
            sreg[0] <= sreg[0]^sreg[1];
        end
    end
 /* Assign statement
    The last value of register assign to output
*/
    assign out = sreg[0];
endmodule