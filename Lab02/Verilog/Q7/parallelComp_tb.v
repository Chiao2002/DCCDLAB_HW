`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/10/18 17:10:49
// Design Name: 
// Module Name: parallelComp_tb
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


module parallelComp_tb();
    reg [10:0] data_in [0:23];
    wire [10:0] min;
    wire [10:0] layer1_out [0:11];
    wire [10:0] layer2_out [0:5];
    wire [10:0] layer3_out [0:2];
    wire [10:0] layer4_out;
    wire signed [5:0] min_value;
    wire signed [4:0] min_index;
    wire signed [5:0] layer1_value [0:11];
    wire signed [4:0] layer1_index [0:11];
    wire signed [5:0] layer2_value [0:5];
    wire signed [4:0] layer2_index [0:5];
    wire signed [5:0] layer3_value [0:2];
    wire signed [4:0] layer3_index [0:2];
    assign min_value = min[10:5];
    assign min_index = min[4:0];
    assign layer1_value[0] = layer1_out[0][10:5];
    assign layer1_value[1] = layer1_out[1][10:5];
    assign layer1_value[2] = layer1_out[2][10:5];
    assign layer1_value[3] = layer1_out[3][10:5];
    assign layer1_value[4] = layer1_out[4][10:5];
    assign layer1_value[5] = layer1_out[5][10:5];
    assign layer1_value[6] = layer1_out[6][10:5];
    assign layer1_value[7] = layer1_out[7][10:5];
    assign layer1_value[8] = layer1_out[8][10:5];
    assign layer1_value[9] = layer1_out[9][10:5];
    assign layer1_value[10] = layer1_out[10][10:5];
    assign layer1_value[11] = layer1_out[11][10:5];
    assign layer1_index[0] = layer1_out[0][4:0];
    assign layer1_index[1] = layer1_out[1][4:0];
    assign layer1_index[2] = layer1_out[2][4:0];
    assign layer1_index[3] = layer1_out[3][4:0];
    assign layer1_index[4] = layer1_out[4][4:0];
    assign layer1_index[5] = layer1_out[5][4:0];
    assign layer1_index[6] = layer1_out[6][4:0];
    assign layer1_index[7] = layer1_out[7][4:0];
    assign layer1_index[8] = layer1_out[8][4:0];
    assign layer1_index[9] = layer1_out[9][4:0];
    assign layer1_index[10] = layer1_out[10][4:0];
    assign layer1_index[11] = layer1_out[11][4:0];
    
    assign layer2_value[0] = layer2_out[0][10:5];
    assign layer2_value[1] = layer2_out[1][10:5];
    assign layer2_value[2] = layer2_out[2][10:5];
    assign layer2_value[3] = layer2_out[3][10:5];
    assign layer2_value[4] = layer2_out[4][10:5];
    assign layer2_value[5] = layer2_out[5][10:5];
    assign layer2_value[6] = layer2_out[6][10:5];
    assign layer2_index[0] = layer2_out[0][4:0];
    assign layer2_index[1] = layer2_out[1][4:0];
    assign layer2_index[2] = layer2_out[2][4:0];
    assign layer2_index[3] = layer2_out[3][4:0];
    assign layer2_index[4] = layer2_out[4][4:0];
    assign layer2_index[5] = layer2_out[5][4:0];
    
    assign layer3_value[0] = layer3_out[0][10:5];
    assign layer3_value[1] = layer3_out[1][10:5];
    assign layer3_value[2] = layer3_out[2][10:5];
    assign layer3_index[0] = layer3_out[0][4:0];
    assign layer3_index[1] = layer3_out[1][4:0];
    assign layer3_index[2] = layer3_out[2][4:0];
    
    parallelComp pc(
        .data_in_1(data_in[0]), .data_in_2(data_in[1]), .data_in_3(data_in[2]),
        .data_in_4(data_in[3]), .data_in_5(data_in[4]), .data_in_6(data_in[5]),
        .data_in_7(data_in[6]), .data_in_8(data_in[7]), .data_in_9(data_in[8]),
        .data_in_10(data_in[9]), .data_in_11(data_in[10]), .data_in_12(data_in[11]),
        .data_in_13(data_in[12]), .data_in_14(data_in[13]), .data_in_15(data_in[14]),
        .data_in_16(data_in[15]), .data_in_17(data_in[16]), .data_in_18(data_in[17]),
        .data_in_19(data_in[18]), .data_in_20(data_in[19]), .data_in_21(data_in[20]),
        .data_in_22(data_in[21]), .data_in_23(data_in[22]), .data_in_24(data_in[23]),
        .layer1_out_1(layer1_out[0]), .layer1_out_2(layer1_out[1]), .layer1_out_3(layer1_out[2]),
        .layer1_out_4(layer1_out[3]), .layer1_out_5(layer1_out[4]), .layer1_out_6(layer1_out[5]),
        .layer1_out_7(layer1_out[6]), .layer1_out_8(layer1_out[7]), .layer1_out_9(layer1_out[8]),
        .layer1_out_10(layer1_out[9]), .layer1_out_11(layer1_out[10]), .layer1_out_12(layer1_out[11]),
        .layer2_out_1(layer2_out[0]), .layer2_out_2(layer2_out[1]), .layer2_out_3(layer2_out[2]),
        .layer2_out_4(layer2_out[3]), .layer2_out_5(layer2_out[4]), .layer2_out_6(layer2_out[5]),
        .layer3_out_1(layer3_out[0]), .layer3_out_2(layer3_out[1]), .layer3_out_3(layer3_out[2]),
        .layer4_out_1(layer4_out), .min(min)
    );
    initial begin
        data_in[0][10:5] = 6'd4; data_in[0][4:0] = 5'd1;
        data_in[1][10:5] = -6'd2; data_in[1][4:0] = 5'd2;
        data_in[2][10:5] = -6'd32; data_in[2][4:0] = 5'd3;
        data_in[3][10:5] = -6'd11; data_in[3][4:0] = 5'd4;
        data_in[4][10:5] = -6'd22; data_in[4][4:0] = 5'd5;
        data_in[5][10:5] = 6'd18; data_in[5][4:0] = 5'd6;
        data_in[6][10:5] = -6'd13; data_in[6][4:0] = 5'd7;
        data_in[7][10:5] = 6'd1; data_in[7][4:0] = 5'd8;
        data_in[8][10:5] = -6'd22; data_in[8][4:0] = 5'd9;
        data_in[9][10:5] = 6'd6; data_in[9][4:0] = 5'd10;
        data_in[10][10:5] = -6'd16; data_in[10][4:0] = 5'd11;
        data_in[11][10:5] = 6'd9; data_in[11][4:0] = 5'd12;
        data_in[12][10:5] = 6'd12; data_in[12][4:0] = 5'd13;
        data_in[13][10:5] = 6'd15; data_in[13][4:0] = 5'd14;
        data_in[14][10:5] = -6'd4; data_in[14][4:0] = 5'd15;
        data_in[15][10:5] = -6'd27; data_in[15][4:0] = 5'd16;
        data_in[16][10:5] = -6'd18; data_in[16][4:0] = 5'd17;
        data_in[17][10:5] = 6'd26; data_in[17][4:0] = 5'd18;
        data_in[18][10:5] = -6'd23; data_in[18][4:0] = 5'd19;
        data_in[19][10:5] = 6'd20; data_in[19][4:0] = 5'd20;
        data_in[20][10:5] = 6'd2; data_in[20][4:0] = 5'd21;
        data_in[21][10:5] = 6'd31; data_in[21][4:0] = 5'd22;
        data_in[22][10:5] = -6'd27; data_in[22][4:0] = 5'd23;
        data_in[23][10:5] = -6'd4; data_in[23][4:0] = 5'd24;
        #250 $stop;
    end
endmodule
