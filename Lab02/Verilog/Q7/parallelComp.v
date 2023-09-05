`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/10/18 17:10:20
// Design Name: 
// Module Name: parallelComp
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


module parallelComp( 
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
    output wire [10:0] layer1_out_1,
    output wire [10:0] layer1_out_2,
    output wire [10:0] layer1_out_3,
    output wire [10:0] layer1_out_4,
    output wire [10:0] layer1_out_5,
    output wire [10:0] layer1_out_6,
    output wire [10:0] layer1_out_7,
    output wire [10:0] layer1_out_8,
    output wire [10:0] layer1_out_9,
    output wire [10:0] layer1_out_10,
    output wire [10:0] layer1_out_11,
    output wire [10:0] layer1_out_12,
    output wire [10:0] layer2_out_1,
    output wire [10:0] layer2_out_2,
    output wire [10:0] layer2_out_3,
    output wire [10:0] layer2_out_4,
    output wire [10:0] layer2_out_5,
    output wire [10:0] layer2_out_6,
    output wire [10:0] layer3_out_1,
    output wire [10:0] layer3_out_2,
    output wire [10:0] layer3_out_3,
    output wire [10:0] layer4_out_1,
    output wire [10:0] min
    );   
    /* Layer 1 */
    cmp_24In L1(
    .data_in_1(data_in_1), .data_in_2(data_in_2), .data_in_3(data_in_3),
    .data_in_4(data_in_4), .data_in_5(data_in_5), .data_in_6(data_in_6),
    .data_in_7(data_in_7), .data_in_8(data_in_8), .data_in_9(data_in_9),
    .data_in_10(data_in_10), .data_in_11(data_in_11), .data_in_12(data_in_12),
    .data_in_13(data_in_13), .data_in_14(data_in_14), .data_in_15(data_in_15),
    .data_in_16(data_in_16), .data_in_17(data_in_17), .data_in_18(data_in_18),
    .data_in_19(data_in_19), .data_in_20(data_in_20), .data_in_21(data_in_21),
    .data_in_22(data_in_22), .data_in_23(data_in_23), .data_in_24(data_in_24),
    .data_out_1(layer1_out_1), .data_out_2(layer1_out_2), .data_out_3(layer1_out_3),
    .data_out_4(layer1_out_4), .data_out_5(layer1_out_5), .data_out_6(layer1_out_6),
    .data_out_7(layer1_out_7), .data_out_8(layer1_out_8), .data_out_9(layer1_out_9),
    .data_out_10(layer1_out_10), .data_out_11(layer1_out_11), .data_out_12(layer1_out_12)
    );   
    /* Layer 2 */
    cmp_12In L2(
    .data_in_1(layer1_out_1), .data_in_2(layer1_out_2), .data_in_3(layer1_out_3),
    .data_in_4(layer1_out_4), .data_in_5(layer1_out_5), .data_in_6(layer1_out_6),
    .data_in_7(layer1_out_7), .data_in_8(layer1_out_7), .data_in_9(layer1_out_9),
    .data_in_10(layer1_out_10), .data_in_11(layer1_out_11), .data_in_12(layer1_out_12),
    .data_out_1(layer2_out_1), .data_out_2(layer2_out_2), .data_out_3(layer2_out_3),
    .data_out_4(layer2_out_4), .data_out_5(layer2_out_5), .data_out_6(layer2_out_6)
    );
    /* Layer 3 */
    cmp_6In L3(
    .data_in_1(layer2_out_1), .data_in_2(layer2_out_2), .data_in_3(layer2_out_3),
    .data_in_4(layer2_out_4), .data_in_5(layer2_out_5), .data_in_6(layer2_out_6),
    .data_out_1(layer3_out_1), .data_out_2(layer3_out_2), .data_out_3(layer3_out_3)
    );
    /* Layer 4 */
    cmp L4(.c1(layer3_out_1), .c2(layer3_out_2), .min(layer4_out_1));
    /* Layer 5 */
    cmp L5(.c1(layer4_out_1), .c2(layer3_out_3), .min(min));    
endmodule

/**  24 Input compare */
module cmp_24In( 
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
    output [10:0] data_out_1,
    output [10:0] data_out_2,
    output [10:0] data_out_3,
    output [10:0] data_out_4,
    output [10:0] data_out_5,
    output [10:0] data_out_6,
    output [10:0] data_out_7,
    output [10:0] data_out_8,
    output [10:0] data_out_9,
    output [10:0] data_out_10,
    output [10:0] data_out_11,
    output [10:0] data_out_12
    );    
    cmp C1(.c1(data_in_1), .c2(data_in_2), .min(data_out_1));
    cmp C2(.c1(data_in_3), .c2(data_in_4), .min(data_out_2));
    cmp C3(.c1(data_in_5), .c2(data_in_6), .min(data_out_3));
    cmp C4(.c1(data_in_7), .c2(data_in_8), .min(data_out_4));
    cmp C5(.c1(data_in_9), .c2(data_in_10), .min(data_out_5));
    cmp C6(.c1(data_in_11), .c2(data_in_12), .min(data_out_6));
    cmp C7(.c1(data_in_13), .c2(data_in_14), .min(data_out_7));
    cmp C8(.c1(data_in_15), .c2(data_in_16), .min(data_out_8));
    cmp C9(.c1(data_in_17), .c2(data_in_18), .min(data_out_9));
    cmp C10(.c1(data_in_19), .c2(data_in_20), .min(data_out_10));
    cmp C11(.c1(data_in_21), .c2(data_in_22), .min(data_out_11));
    cmp C12(.c1(data_in_23), .c2(data_in_24), .min(data_out_12));    
endmodule
/**  12 Input compare */
module cmp_12In( 
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
    output [10:0] data_out_1,
    output [10:0] data_out_2,
    output [10:0] data_out_3,
    output [10:0] data_out_4,
    output [10:0] data_out_5,
    output [10:0] data_out_6
    );
    cmp C1(.c1(data_in_1), .c2(data_in_2), .min(data_out_1));
    cmp C2(.c1(data_in_3), .c2(data_in_4), .min(data_out_2));
    cmp C3(.c1(data_in_5), .c2(data_in_6), .min(data_out_3));
    cmp C4(.c1(data_in_7), .c2(data_in_8), .min(data_out_4));
    cmp C5(.c1(data_in_9), .c2(data_in_10), .min(data_out_5));
    cmp C6(.c1(data_in_11), .c2(data_in_12), .min(data_out_6));      
endmodule
/**  6 Input compare */
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