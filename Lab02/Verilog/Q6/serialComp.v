`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/10/17 12:49:44
// Design Name: 
// Module Name: serialComp
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


module serialComp(clk, rstn, data_in, sc_out);
    input clk,rstn;
    input [10:0] data_in;
    output reg [10:0] sc_out;   
    reg  comp_out;
    reg [10:0] d1_data_in;
    /*  Comparator */
    always@(*) begin
        case({data_in[10], sc_out[10]})
            2'b01:begin   /* data_in : + ,  sc_out : - */
                comp_out = 0;
            end
            2'b10:begin   /* data_in : - ,  sc_out : + */
                comp_out = 1;
            end
            2'b11:begin   /* data_in : - ,  sc_out : - */
                if (data_in[9:5] < sc_out[9:5])
                    comp_out = 1;
                else
                    comp_out = 0;
            end
            2'b00:begin   /* data_in : + ,  sc_out : + */
                if (data_in[9:5] < sc_out[9:5])
                    comp_out = 1;
                else
                    comp_out = 0;
            end
            default:begin
                comp_out = 0;
            end
        endcase  
    end
    /*  Flip-flop */
    always@(posedge clk or posedge rstn) begin
        if (rstn == 1'b1) begin
            sc_out <= 11'b011_1110_0000;
        end else begin
            if (comp_out == 1)
                sc_out <= data_in;
            else
                sc_out <= sc_out;
        end
     end     
endmodule
