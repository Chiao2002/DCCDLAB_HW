`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/10/19 11:47:45
// Design Name: 
// Module Name: cmp
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


module cmp(c1, c2, max, min);
    input [10:0] c1,c2;
    output [10:0] max, min;
    
    reg signed [10:0] comp_out;
    reg signed [10:0] max, min;
    
    always@(*) begin
        case({c1[10],c2[10]})
            2'b01:begin   /* c1 : + ,  c2 : - */
                comp_out = 0;
            end
            2'b10:begin   /* c1 : - ,  c2 : + */
                comp_out = 1;
            end
            2'b11:begin   /* c1 : - ,  c2 : - */
                if (c1[9:5] < c2[9:5])
                    comp_out = 1;
                else
                    comp_out = 0;
            end
            2'b00:begin   /* c1 : + ,  c2 : + */
                if (c1[9:5] < c2[9:5])
                    comp_out = 1;
                else
                    comp_out = 0;
            end
            default:begin
                comp_out = 0;
            end
        endcase
    end
    
//    assign cout = comp_out ? c1 : c2;
    always@(*) begin
        if(comp_out == 1) begin
            max = c2;
            min = c1;
        end else begin
            max = c1;
            min = c2;
        end
    end
    
endmodule
