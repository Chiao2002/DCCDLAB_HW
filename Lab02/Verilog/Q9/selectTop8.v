`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/10/19 12:38:26
// Design Name: 
// Module Name: selectTop8
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


module selectTop8(
    input clk, 
    input rst,
    input [10:0] data_in_1,
    input [10:0] data_in_2,
    input [10:0] data_in_3,
    input [10:0] data_in_4,
    input [10:0] data_in_5,
    input [10:0] data_in_6,
    input [10:0] data_in_7,
    input [10:0] data_in_8,
    input [10:0] data_in_9,
    input [10:0] data_in_10,
    input [10:0] data_in_11,
    input [10:0] data_in_12,
    input [10:0] data_in_13,
    input [10:0] data_in_14,
    input [10:0] data_in_15,
    input [10:0] data_in_16,
    input [10:0] data_in_17,
    input [10:0] data_in_18,
    input [10:0] data_in_19,
    input [10:0] data_in_20,
    input [10:0] data_in_21,
    input [10:0] data_in_22,
    input [10:0] data_in_23,
    input [10:0] data_in_24,
    output [10:0] min
    );
    wire [10:0] G1 [0:3];
    wire [10:0] G2 [0:3];
    wire [10:0] G3 [0:3];
    wire [10:0] G4 [0:3];
    wire [10:0] G5 [0:3];
    wire [10:0] G6 [0:3];
    
    wire [10:0] layer1_out_1;
    wire [10:0] layer1_out_2;
    wire [10:0] layer1_out_3;
    wire [10:0] layer2_out_1;
    wire [10:0] layer2_out_2;
    wire [10:0] layer3_out_1;
    
    reg [1:0] pointer[0:5];
    
    sort4 S1(
    .data_in_1(data_in_1), .data_in_2(data_in_2), .data_in_3(data_in_3), .data_in_4(data_in_4),
    .data_out_1(G1[0]), .data_out_2(G1[1]), .data_out_3(G1[2]), .data_out_4(G1[3])
    );
    sort4 S2(
    .data_in_1(data_in_5), .data_in_2(data_in_6), .data_in_3(data_in_7), .data_in_4(data_in_8),
    .data_out_1(G2[0]), .data_out_2(G2[1]), .data_out_3(G2[2]), .data_out_4(G2[3])
    );
    sort4 S3(
    .data_in_1(data_in_9), .data_in_2(data_in_10), .data_in_3(data_in_11), .data_in_4(data_in_12),
    .data_out_1(G3[0]), .data_out_2(G3[1]), .data_out_3(G3[2]), .data_out_4(G3[3])
    );
    sort4 S4(
    .data_in_1(data_in_13), .data_in_2(data_in_14), .data_in_3(data_in_15), .data_in_4(data_in_16),
    .data_out_1(G4[0]), .data_out_2(G4[1]), .data_out_3(G4[2]), .data_out_4(G4[3])
    );
    sort4 S5(
    .data_in_1(data_in_17), .data_in_2(data_in_18), .data_in_3(data_in_19), .data_in_4(data_in_20),
    .data_out_1(G5[0]), .data_out_2(G5[1]), .data_out_3(G5[2]), .data_out_4(G5[3])
    );
    sort4 S6(
    .data_in_1(data_in_21), .data_in_2(data_in_22), .data_in_3(data_in_23), .data_in_4(data_in_24),
    .data_out_1(G6[0]), .data_out_2(G6[1]), .data_out_3(G6[2]), .data_out_4(G6[3])
    );
    /**  Layer 1 */
    cmp_6In L1(
    .data_in_1(G1[pointer[0]]), .data_in_2(G2[pointer[1]]), .data_in_3(G3[pointer[2]]),
    .data_in_4(G4[pointer[3]]), .data_in_5(G5[pointer[4]]), .data_in_6(G6[pointer[5]]),
    .data_out_1(layer1_out_1), .data_out_2(layer1_out_2), .data_out_3(layer1_out_3)
    );
    /**  Layer 2 */
    cmp L2(.c1(layer1_out_1), .c2(layer1_out_2), .max(layer2_out_1), .min(layer2_out_2));
    
    /**  Layer 3 */
    cmp L3(.c1(layer2_out_2), .c2(layer1_out_3), .max(layer3_out_1), .min(min));
    
    always@(posedge clk or posedge rst) begin
        if(rst == 1) begin
            pointer[0] <= 2'b00;
            pointer[1] <= 2'b00;
            pointer[2] <= 2'b00;
            pointer[3] <= 2'b00;
            pointer[4] <= 2'b00;
            pointer[5] <= 2'b00;
	    end else begin
		    case(min[4:0])
                5'd1, 5'd2, 5'd3, 5'd4: pointer[0] <= pointer[0] + 1'b1;
                5'd5, 5'd6, 5'd7, 5'd8: pointer[1] <= pointer[1] + 1'b1;
                5'd9, 5'd10, 5'd11, 5'd12: pointer[2] <= pointer[2] + 1'b1;
                5'd13, 5'd14, 5'd15, 5'd16: pointer[3] <= pointer[3] + 1'b1;
                5'd17, 5'd18, 5'd19, 5'd20: pointer[4] <= pointer[4] + 1'b1;
                5'd21, 5'd22, 5'd23, 5'd24: pointer[5] <= pointer[5] + 1'b1;        
			    default: begin
			          pointer[0] <= 2'b00;
		              pointer[1] <= 2'b00;
		              pointer[2] <= 2'b00;
		              pointer[3] <= 2'b00;
		              pointer[4] <= 2'b00;
		              pointer[5] <= 2'b00;
			    end
		    endcase
	     end
     end
endmodule

