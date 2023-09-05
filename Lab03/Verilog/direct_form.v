`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/01 09:46:21
// Design Name: 
// Module Name: direct_form
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


module direct_form( clk, rst, input_x, output_y );
    input clk, rst;
    input signed [16:0] input_x;
    output signed [19:0] output_y;
    reg signed [19:0] output_y;
    wire signed [19:0] direct_output_y;
    reg signed [16:0] directform_reg [0:23];
    wire signed [16:0] h [0:24];
//    wire signed [33:0] w [0:24];
    wire signed [33:0] w0,w1,w2,w3,w4,w5,w6,w7,w8,w9,w10,
                      w11,w12,w13,w14,w15,w16,w17,w18,w19,
                      w20,w21,w22,w23,w24;
//    wire signed [19:0] w_trun [0:24];
    wire signed [19:0] w_trun0,w_trun1,w_trun2,w_trun3,w_trun4,w_trun5,w_trun6,w_trun7,w_trun8,w_trun9,w_trun10,
                      w_trun11,w_trun12,w_trun13,w_trun14,w_trun15,w_trun16,w_trun17,w_trun18,w_trun19,w_trun20,
                      w_trun21,w_trun22,w_trun23,w_trun24;
    wire signed [19:0] add_out [0:22];
    
    // coefficient
    assign h[0] = 0;
    assign h[1] = 1673;
    assign h[2] = 2838;
    assign h[3] = 2407;
    assign h[4] = -1;
    assign h[5] = -3509;
    assign h[6] = -6083;
    assign h[7] = -5380;
    assign h[8] = 0;
    assign h[9] = 9514;
    assign h[10] = 20557;
    assign h[11] = 29393;
    assign h[12] = 32768;
    assign h[13] = 29393;
    assign h[14] = 20557;
    assign h[15] = 9514;
    assign h[16] = 0;
    assign h[17] = -5380;
    assign h[18] = -6083;
    assign h[19] = -3509;
    assign h[20] = -1;
    assign h[21] = 2407;
    assign h[22] = 2838;
    assign h[23] = 1673;
    assign h[24] = 0;
    // multiplication
    assign w0 = input_x*h[0];
    assign w1 = directform_reg[0]*h[1];
    assign w2 = directform_reg[1]*h[2];
    assign w3 = directform_reg[2]*h[3];
    assign w4 = directform_reg[3]*h[4];
    assign w5 = directform_reg[4]*h[5];
    assign w6 = directform_reg[5]*h[6];
    assign w7 = directform_reg[6]*h[7];
    assign w8 = directform_reg[7]*h[8];
    assign w9 = directform_reg[8]*h[9];
    assign w10 = directform_reg[9]*h[10];
    assign w11 = directform_reg[10]*h[11];
    assign w12 = directform_reg[11]*h[12];
    assign w13 = directform_reg[12]*h[13];
    assign w14 = directform_reg[13]*h[14];
    assign w15 = directform_reg[14]*h[15];
    assign w16 = directform_reg[15]*h[16];
    assign w17 = directform_reg[16]*h[17];
    assign w18 = directform_reg[17]*h[18];
    assign w19 = directform_reg[18]*h[19];
    assign w20 = directform_reg[19]*h[20];
    assign w21 = directform_reg[20]*h[21];
    assign w22 = directform_reg[21]*h[22];
    assign w23 = directform_reg[22]*h[23];
    assign w24 = directform_reg[23]*h[24];
//    assign w[0] = input_x*h[0];
//    assign w[1] = directform_reg[0]*h[1];
//    assign w[2] = directform_reg[1]*h[2];
//    assign w[3] = directform_reg[2]*h[3];
//    assign w[4] = directform_reg[3]*h[4];
//    assign w[5] = directform_reg[4]*h[5];
//    assign w[6] = directform_reg[5]*h[6];
//    assign w[7] = directform_reg[6]*h[7];
//    assign w[8] = directform_reg[7]*h[8];
//    assign w[9] = directform_reg[8]*h[9];
//    assign w[10] = directform_reg[9]*h[10];
//    assign w[11] = directform_reg[10]*h[11];
//    assign w[12] = directform_reg[11]*h[12];
//    assign w[13] = directform_reg[12]*h[13];
//    assign w[14] = directform_reg[13]*h[14];
//    assign w[15] = directform_reg[14]*h[15];
//    assign w[16] = directform_reg[15]*h[16];
//    assign w[17] = directform_reg[16]*h[17];
//    assign w[18] = directform_reg[17]*h[18];
//    assign w[19] = directform_reg[18]*h[19];
//    assign w[20] = directform_reg[19]*h[20];
//    assign w[21] = directform_reg[20]*h[21];
//    assign w[22] = directform_reg[21]*h[22];
//    assign w[23] = directform_reg[22]*h[23];
//    assign w[24] = directform_reg[23]*h[24];
    // truncation
    assign w_trun0 = w0[31:12];
    assign w_trun1 = w1[31:12];
    assign w_trun2 = w2[31:12];
    assign w_trun3 = w3[31:12];
    assign w_trun4 = w4[31:12];
    assign w_trun5 = w5[31:12];
    assign w_trun6 = w6[31:12];
    assign w_trun7 = w7[31:12];
    assign w_trun8 = w8[31:12];
    assign w_trun9 = w9[31:12];
    assign w_trun10 = w10[31:12];
    assign w_trun11 = w1[31:12];
    assign w_trun12 = w12[31:12];
    assign w_trun13 = w13[31:12];
    assign w_trun14 = w14[31:12];
    assign w_trun15 = w15[31:12];
    assign w_trun16 = w16[31:12];
    assign w_trun17 = w17[31:12];
    assign w_trun18 = w18[31:12];
    assign w_trun19 = w19[31:12];
    assign w_trun20 = w20[31:12];
    assign w_trun21 = w21[31:12];
    assign w_trun22 = w22[31:12];
    assign w_trun23 = w23[31:12];
    assign w_trun24 = w24[31:12]; 
//    assign w_trun[0] = w[0][31:12];
//    assign w_trun[1] = w[1][31:12];
//    assign w_trun[2] = w[2][31:12];
//    assign w_trun[3] = w[3][31:12];
//    assign w_trun[4] = w[4][31:12];
//    assign w_trun[5] = w[5][31:12];
//    assign w_trun[6] = w[6][31:12];
//    assign w_trun[7] = w[7][31:12];
//    assign w_trun[8] = w[8][31:12];
//    assign w_trun[9] = w[9][31:12];
//    assign w_trun[10] = w[10][31:12];
//    assign w_trun[11] = w[11][31:12];
//    assign w_trun[12] = w[12][31:12];
//    assign w_trun[13] = w[13][31:12];
//    assign w_trun[14] = w[14][31:12];
//    assign w_trun[15] = w[15][31:12];
//    assign w_trun[16] = w[16][31:12];
//    assign w_trun[17] = w[17][31:12];
//    assign w_trun[18] = w[18][31:12];
//    assign w_trun[19] = w[19][31:12];
//    assign w_trun[20] = w[20][31:12];
//    assign w_trun[21] = w[21][31:12];
//    assign w_trun[22] = w[22][31:12];
//    assign w_trun[23] = w[23][31:12];
//    assign w_trun[24] = w[24][31:12];    
    // addition
//    assign add_out[0] = w_trun[0] + w_trun[1];
//    assign add_out[1] = add_out[0] + w_trun[2];
//    assign add_out[2] = add_out[1] + w_trun[3];
//    assign add_out[3] = add_out[2] + w_trun[4];
//    assign add_out[4] = add_out[3] + w_trun[5];
//    assign add_out[5] = add_out[4] + w_trun[6];
//    assign add_out[6] = add_out[5] + w_trun[7];
//    assign add_out[7] = add_out[6] + w_trun[8];
//    assign add_out[8] = add_out[7] + w_trun[9];
//    assign add_out[9] = add_out[8] + w_trun[10];
//    assign add_out[10] = add_out[9] + w_trun[11];
//    assign add_out[11] = add_out[10] + w_trun[12];
//    assign add_out[12] = add_out[11] + w_trun[13];
//    assign add_out[13] = add_out[12] + w_trun[14];
//    assign add_out[14] = add_out[13] + w_trun[15];
//    assign add_out[15] = add_out[14] + w_trun[16];
//    assign add_out[16] = add_out[15] + w_trun[17];
//    assign add_out[17] = add_out[16] + w_trun[18];
//    assign add_out[18] = add_out[17] + w_trun[19];
//    assign add_out[19] = add_out[18] + w_trun[20];
//    assign add_out[20] = add_out[19] + w_trun[21];
//    assign add_out[21] = add_out[20] + w_trun[22];
//    assign add_out[22] = add_out[21] + w_trun[23];
//    assign output_y = add_out[22] + w_trun[24];    
    
    
    assign add_out[0] = {w_trun0[19], w_trun0[19:1]} + {{w_trun1[19]}, w_trun1[19:1]};
    assign add_out[1] = add_out[0] + {{w_trun2[19]}, w_trun2[19:1]};
    assign add_out[2] = add_out[1] + {{w_trun3[19]}, w_trun3[19:1]};
    assign add_out[3] = add_out[2] + {{w_trun4[19]}, w_trun4[19:1]};
    assign add_out[4] = add_out[3] + {{w_trun5[19]}, w_trun5[19:1]};
    assign add_out[5] = add_out[4] + {{w_trun6[19]}, w_trun6[19:1]};
    assign add_out[6] = add_out[5] + {{w_trun7[19]}, w_trun7[19:1]};
    assign add_out[7] = add_out[6] + {{w_trun8[19]}, w_trun8[19:1]};
    assign add_out[8] = add_out[7] + {{w_trun9[19]}, w_trun9[19:1]};
    assign add_out[9] = add_out[8] + {{w_trun10[19]}, w_trun10[19:1]};
    assign add_out[10] = add_out[9] + {{w_trun11[19]}, w_trun11[19:1]};
    assign add_out[11] = add_out[10] + {{w_trun12[19]}, w_trun12[19:1]};
    assign add_out[12] = add_out[11] + {{w_trun13[19]}, w_trun13[19:1]};
    assign add_out[13] = add_out[12] + {{w_trun14[19]}, w_trun14[19:1]};
    assign add_out[14] = add_out[13] + {{w_trun15[19]}, w_trun15[19:1]};
    assign add_out[15] = add_out[14] + {{w_trun16[19]}, w_trun16[19:1]};
    assign add_out[16] = add_out[15] + {{w_trun17[19]}, w_trun17[19:1]};
    assign add_out[17] = add_out[16] + {{w_trun18[19]}, w_trun18[19:1]};
    assign add_out[18] = add_out[17] + {{w_trun19[19]}, w_trun19[19:1]};
    assign add_out[19] = add_out[18] + {{w_trun20[19]}, w_trun20[19:1]};
    assign add_out[20] = add_out[19] + {{w_trun21[19]}, w_trun21[19:1]};
    assign add_out[21] = add_out[20] + {{w_trun22[19]}, w_trun22[19:1]};
    assign add_out[22] = add_out[21] + {{w_trun23[19]}, w_trun23[19:1]};
    assign direct_output_y = add_out[22] + {{w_trun24[19]}, w_trun24[19:1]};
    
    always@( posedge clk )
    begin
        output_y <= direct_output_y;
    end
 

//    assign output_y = w_trun[0] 
//                    + w_trun[1]
//                    + w_trun[2]
//                    + w_trun[3]
//                    + w_trun[4]
//                    + w_trun[5]
//                    + w_trun[6]
//                    + w_trun[7]
//                    + w_trun[8]
//                    + w_trun[9]
//                    + w_trun[10]
//                    + w_trun[11]
//                    + w_trun[12]
//                    + w_trun[13]
//                    + w_trun[14]
//                    + w_trun[15]
//                    + w_trun[16]
//                    + w_trun[17]
//                    + w_trun[18]
//                    + w_trun[19]
//                    + w_trun[20]
//                    + w_trun[21]
//                    + w_trun[22]
//                    + w_trun[23]
//                    + w_trun[24];
       
    always@(posedge clk or posedge rst) begin
        if (rst == 1) begin
            directform_reg[0] <= 0;
            directform_reg[1] <= 0;
            directform_reg[2] <= 0;
            directform_reg[3] <= 0;
            directform_reg[4] <= 0;
            directform_reg[5] <= 0;
            directform_reg[6] <= 0;
            directform_reg[7] <= 0;
            directform_reg[8] <= 0;
            directform_reg[9] <= 0;
            directform_reg[10] <= 0;
            directform_reg[11] <= 0;
            directform_reg[12] <= 0;
            directform_reg[13] <= 0;
            directform_reg[14] <= 0;
            directform_reg[15] <= 0;
            directform_reg[16] <= 0;
            directform_reg[17] <= 0;
            directform_reg[18] <= 0;
            directform_reg[19] <= 0;
            directform_reg[20] <= 0;
            directform_reg[21] <= 0;
            directform_reg[22] <= 0;
            directform_reg[23] <= 0;
        end else begin
            directform_reg[0] <= input_x;
            directform_reg[1] <= directform_reg[0];
            directform_reg[2] <= directform_reg[1];
            directform_reg[3] <= directform_reg[2];
            directform_reg[4] <= directform_reg[3];
            directform_reg[5] <= directform_reg[4];
            directform_reg[6] <= directform_reg[5];
            directform_reg[7] <= directform_reg[6];
            directform_reg[8] <= directform_reg[7];
            directform_reg[9] <= directform_reg[8];
            directform_reg[10] <= directform_reg[9];
            directform_reg[11] <= directform_reg[10];
            directform_reg[12] <= directform_reg[11];
            directform_reg[13] <= directform_reg[12];
            directform_reg[14] <= directform_reg[13];
            directform_reg[15] <= directform_reg[14];
            directform_reg[16] <= directform_reg[15];
            directform_reg[17] <= directform_reg[16];
            directform_reg[18] <= directform_reg[17];
            directform_reg[19] <= directform_reg[18];
            directform_reg[20] <= directform_reg[19];
            directform_reg[21] <= directform_reg[20];
            directform_reg[22] <= directform_reg[21];
            directform_reg[23] <= directform_reg[22];      
        end    
    end   
endmodule
