`timescale 1ns / 1ps

module Iteration_Stage(
    input  CLK, RSTN,
    input  Enable,
    input  signed [11:0] X, Y,
    input  [13:0] Phase_in,
    output [11:0] X_i, Y_i,
    output [13:0] Phase_out
    );
    parameter stage_no = 0;
    reg  [11:0] X_reg, Y_reg;
    reg  [13:0] Phase_reg;
    wire [13:0] atan;
    wire [11:0] X_sft, Y_sft;
    
    assign X_i = X_reg;
    assign Y_i = Y_reg;
    assign Phase_out = Phase_reg;
    assign X_sft = X>>>stage_no;
    assign Y_sft = Y>>>stage_no;
    
    always @(posedge CLK or negedge RSTN) begin
        if(~RSTN) begin
            X_reg <= 0;
            Y_reg <= 0;
            Phase_reg <= 0;
        end
        else if(Enable) begin
            X_reg <= Y[11]? X-Y_sft:X+Y_sft;
            Y_reg <= Y[11]? Y+X_sft:Y-X_sft;
            Phase_reg <= Y[11]? Phase_in-atan:Phase_in+atan;
        end
    end
    
    generate
        case(stage_no)
            0: begin
                assign atan = 804; 
            end
            1: begin
                assign atan = 475; 
            end
            2: begin
                assign atan = 251; 
            end
            3: begin
                assign atan = 127; 
            end
            4: begin
                assign atan = 64; 
            end
            5: begin
                assign atan = 32; 
            end
            6: begin
                assign atan = 16; 
            end
            7: begin
                assign atan = 8; 
            end
            8: begin
                assign atan = 4; 
            end
            default: begin
                assign atan = 0; 
            end
        endcase
    endgenerate
  
endmodule
