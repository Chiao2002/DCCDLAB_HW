`timescale 1ns / 1ps

module CORDIC_TB( );
    reg CLK, RSTN;
    wire [11:0] X, Y;
    wire [11:0] Amp;
    wire [13:0] Phase;
    wire m_tvalid, m_tready;
    wire [31:0] m_tdata;
    wire s_tvalid, s_tready;
    wire [31:0] s_tdata;
    
    assign m_tready = m_tvalid;
    assign X = m_tdata[27:16];
    assign Y = m_tdata[11:0];
    assign s_tvalid = 1;
    assign s_tdata = {4'd0, Amp, 2'd0, Phase};
    
    MATLAB_FILE_IN_D_AXI #(.File_name("cordic_output4sim.txt"))
    Data_In( 
      .CLK(CLK), .RSTN(RSTN),
      .m_axis_tvalid(m_tvalid),
      .m_axis_tready(m_tready),
      .m_axis_tdata(m_tdata),
      .Filein_C()
    );
    
    CORDIC_Vectoring
    uut (
    .CLK(CLK), 
    .RSTN(RSTN),
    .Enable(m_tvalid),
    .X(X), 
    .Y(Y),
    .Amplitude(Amp),
    .Phase(Phase)
    );
    
    MATLAB_FILE_OUT_D_AXI #(.File_name("cordic_verilog_output.txt"))
    Data_out (
      .CLK(CLK), 
      .RSTN(RSTN),   
      .s_axis_tvalid(s_tvalid),
      .s_axis_tready(s_tready),
      .s_axis_tdata(s_tdata),
      .Fileout_C()
    );

    initial begin
        CLK=0;
        RSTN=0;
        #105 RSTN=1;
    end
    always #5 CLK=~CLK;
endmodule
