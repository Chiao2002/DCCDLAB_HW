`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/02 15:26:09
// Design Name: 
// Module Name: transposed_form
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


module transposed_form( clk, rst, input_x, output_y );
    input clk, rst;
    input signed [18:0] input_x;
    output reg signed [19:0] output_y;
    
    reg signed [21:0] trans_output_y;
    reg signed [21:0] transform_reg [0:23];
    wire signed [17:0] h [0:24];
    wire signed [36:0] w [0:24];
    wire signed [21:0] w_trun [0:24];
    
    // coefficient
    assign h[0] = 0;
    assign h[1] = 3346;
    assign h[2] = 5676;
    assign h[3] = 4815;
    assign h[4] = -1;
    assign h[5] = -7017;
    assign h[6] = -12165;
    assign h[7] = -10759;
    assign h[8] = 0;
    assign h[9] = 19029;
    assign h[10] = 41115;
    assign h[11] = 58787;
    assign h[12] = 65536;
    assign h[13] = 58787;
    assign h[14] = 41115;
    assign h[15] = 19029;
    assign h[16] = 0;
    assign h[17] = -10759;
    assign h[18] = -12165;
    assign h[19] = -7017;
    assign h[20] = -1;
    assign h[21] = 4815;
    assign h[22] = 5676;
    assign h[23] = 3346;
    assign h[24] = 0;    
    // multiplication
    assign w[24] = input_x * h[0];
    assign w[23] = input_x * h[1];
    assign w[22] = input_x * h[2];
    assign w[21] = input_x * h[3];
    assign w[20] = input_x * h[4];
    assign w[19] = input_x * h[5];
    assign w[18] = input_x * h[6];
    assign w[17] = input_x * h[7];
    assign w[16] = input_x * h[8];
    assign w[15] = input_x * h[9];
    assign w[14] = input_x * h[10];
    assign w[13] = input_x * h[11];
    assign w[12] = input_x * h[12];
    assign w[11] = input_x * h[13];
    assign w[10] = input_x * h[14];
    assign w[9] = input_x * h[15];
    assign w[8] = input_x * h[16];
    assign w[7] = input_x * h[17];
    assign w[6] = input_x * h[18];
    assign w[5] = input_x * h[19];
    assign w[4] = input_x * h[20];
    assign w[3] = input_x * h[21];
    assign w[2] = input_x * h[22];
    assign w[1] = input_x * h[23];
    assign w[0] = input_x * h[24];
    // truncation
    assign w_trun[24] = w[24][34:13];
    assign w_trun[23] = w[23][34:13];
    assign w_trun[22] = w[22][34:13];
    assign w_trun[21] = w[21][34:13];
    assign w_trun[20] = w[20][34:13];
    assign w_trun[19] = w[19][34:13];
    assign w_trun[18] = w[18][34:13];
    assign w_trun[17] = w[17][34:13];
    assign w_trun[16] = w[16][34:13];
    assign w_trun[15] = w[15][34:13];
    assign w_trun[14] = w[14][34:13];
    assign w_trun[13] = w[13][34:13];
    assign w_trun[12] = w[12][34:13];
    assign w_trun[11] = w[11][34:13];
    assign w_trun[10] = w[10][34:13];
    assign w_trun[9] = w[9][34:13];
    assign w_trun[8] = w[8][34:13];
    assign w_trun[7] = w[7][34:13];
    assign w_trun[6] = w[6][34:13];
    assign w_trun[5] = w[5][34:13];
    assign w_trun[4] = w[4][34:13];
    assign w_trun[3] = w[3][34:13];
    assign w_trun[2] = w[2][34:13];
    assign w_trun[1] = w[1][34:13];
    assign w_trun[0] = w[0][34:13];
    
    always@(posedge clk or posedge rst) begin
        if (rst == 1) begin
            transform_reg[23] <= 0;
            transform_reg[22] <= 0;
            transform_reg[21] <= 0;
            transform_reg[20] <= 0;
            transform_reg[19] <= 0;
            transform_reg[18] <= 0;
            transform_reg[17] <= 0;
            transform_reg[16] <= 0;
            transform_reg[15] <= 0;
            transform_reg[14] <= 0;
            transform_reg[13] <= 0;
            transform_reg[12] <= 0;
            transform_reg[11] <= 0;
            transform_reg[10] <= 0;
            transform_reg[9] <= 0;
            transform_reg[8] <= 0;
            transform_reg[7] <= 0;
            transform_reg[6] <= 0;
            transform_reg[5] <= 0;
            transform_reg[4] <= 0;
            transform_reg[3] <= 0;
            transform_reg[2] <= 0;
            transform_reg[1] <= 0;
            transform_reg[0] <= 0;
        end else begin
            output_y = trans_output_y[21:2];
            trans_output_y = transform_reg[23] + {w_trun[24][21], w_trun[24][21:1]};
            transform_reg[23] = transform_reg[22] + {w_trun[23][21], w_trun[23][21:1]};
            transform_reg[22] = transform_reg[21] + {w_trun[22][21], w_trun[22][21:1]};
            transform_reg[21] = transform_reg[20] + {w_trun[21][21], w_trun[21][21:1]};
            transform_reg[20] = transform_reg[19] + {w_trun[20][21], w_trun[20][21:1]};
            transform_reg[19] = transform_reg[18] + {w_trun[19][21], w_trun[19][21:1]};
            transform_reg[18] = transform_reg[17] + {w_trun[18][21], w_trun[18][21:1]};
            transform_reg[17] = transform_reg[16] + {w_trun[17][21], w_trun[17][21:1]};
            transform_reg[16] = transform_reg[15] + {w_trun[16][21], w_trun[16][21:1]};
            transform_reg[15] = transform_reg[14] + {w_trun[15][21], w_trun[15][21:1]};
            transform_reg[14] = transform_reg[13] + {w_trun[14][21], w_trun[14][21:1]};
            transform_reg[13] = transform_reg[12] + {w_trun[13][21], w_trun[13][21:1]};
            transform_reg[12] = transform_reg[11] + {w_trun[12][21], w_trun[12][21:1]};
            transform_reg[11] = transform_reg[10] + {w_trun[11][21], w_trun[11][21:1]};
            transform_reg[10] = transform_reg[9] + {w_trun[10][21], w_trun[10][21:1]};
            transform_reg[9] = transform_reg[8] + {w_trun[9][21], w_trun[9][21:1]};
            transform_reg[8] = transform_reg[7] + {w_trun[8][21], w_trun[8][21:1]};
            transform_reg[7] = transform_reg[6] + {w_trun[7][21], w_trun[7][21:1]};
            transform_reg[6] = transform_reg[5] + {w_trun[6][21], w_trun[6][21:1]};
            transform_reg[5] = transform_reg[4] + {w_trun[5][21], w_trun[5][21:1]};
            transform_reg[4] = transform_reg[3] + {w_trun[4][21], w_trun[4][21:1]};
            transform_reg[3] = transform_reg[2] + {w_trun[3][21], w_trun[3][21:1]};
            transform_reg[2] = transform_reg[1] + {w_trun[2][21], w_trun[2][21:1]};
            transform_reg[1] = transform_reg[0] + {w_trun[1][21], w_trun[1][21:1]};
            transform_reg[0] = {w_trun[0][21], w_trun[0][21:1]};          
        end
    end
endmodule
