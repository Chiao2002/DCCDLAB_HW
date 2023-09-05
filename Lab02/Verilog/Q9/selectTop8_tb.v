`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/10/19 12:39:00
// Design Name: 
// Module Name: selectTop8_tb
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


module selectTop8_tb();
    reg clock;
    reg reset;
    reg [10:0] data_in[0:23];
    wire [10:0] min;
    wire signed[5:0] min_value;
    wire [4:0] index;
    assign min_value = min[10:5];
    assign index = min[4:0];
    selectTop8 uut(
    .clk(clock),
    .rst(reset),
    .data_in_1(data_in[0]), .data_in_2(data_in[1]), .data_in_3(data_in[2]),
    .data_in_4(data_in[3]), .data_in_5(data_in[4]), .data_in_6(data_in[5]),
    .data_in_7(data_in[6]), .data_in_8(data_in[7]), .data_in_9(data_in[8]),
    .data_in_10(data_in[9]), .data_in_11(data_in[10]), .data_in_12(data_in[11]),
    .data_in_13(data_in[12]), .data_in_14(data_in[13]), .data_in_15(data_in[14]),
    .data_in_16(data_in[15]), .data_in_17(data_in[16]), .data_in_18(data_in[17]),
    .data_in_19(data_in[18]), .data_in_20(data_in[19]), .data_in_21(data_in[20]),
    .data_in_22(data_in[21]), .data_in_23(data_in[22]), .data_in_24(data_in[23]),
    .min(min)
    );
    always #20 clock = ~clock;
    initial begin
        clock = 0;
        reset = 0;
        /*  Read file */
//        i = 0;
//        fp_r = $fopen("dataIn.txt","r");
//        while(!$feof(fp_r)) begin
//            status = $fscanf(fp_r, "%d %d\n", data_in[i][10:5], data_in[i][4:0]);
//            i = i + 1;
//        end
//        $fclose(fp_r);    
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
        
        #40 reset = 1;
        #5 reset = 0;
        #1500 $stop;
    end

endmodule
