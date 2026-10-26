module Demux_LFSR_Project_Top
  (input  i_Clk,
   input  i_Rst,
   input  i_Switch_1,
   input  i_Switch_2,
   output o_LED_1,
   output o_LED_2,
   output o_LED_3,
   output o_LED_4);

  reg r_LFSR_Toggle;
  wire w_LFSR_Done;
  wire w_Sel0 = ~i_Switch_1;
  wire w_Sel1 = ~i_Switch_2;

  always @(posedge i_Clk)
  begin
    if (i_Rst == 1'b0)
      r_LFSR_Toggle <= 1'b0;
    else if (w_LFSR_Done)
      r_LFSR_Toggle <= !r_LFSR_Toggle;
  end

  LFSR_22 LFSR_Inst
   (.i_Clk(i_Clk),
    .i_Rst(i_Rst),
    .o_LFSR_Data(),
    .o_LFSR_Done(w_LFSR_Done));

  Demux_1_To_4 Demux_Inst
   (.i_Data(r_LFSR_Toggle),
    .i_Sel0(w_Sel0),
    .i_Sel1(w_Sel1),
    .o_Data0(o_LED_1),
    .o_Data1(o_LED_2),
    .o_Data2(o_LED_3),
    .o_Data3(o_LED_4));
endmodule

module LFSR_22 (
  input         i_Clk,
  input         i_Rst,
  output [21:0] o_LFSR_Data,
  output        o_LFSR_Done);

  reg [21:0] r_LFSR;
  wire       w_XNOR;

  always @(posedge i_Clk)
  begin
    if (i_Rst == 1'b0)
      r_LFSR <= 22'h1;
    else
      r_LFSR <= {r_LFSR[20:0], w_XNOR};
  end

  assign w_XNOR = r_LFSR[21] ^~ r_LFSR[20];
  assign o_LFSR_Done = (r_LFSR == 22'd1);
  assign o_LFSR_Data = r_LFSR;
endmodule

module Demux_1_To_4
  (input  i_Data,
   input  i_Sel1,
   input  i_Sel0,
   output o_Data0,
   output o_Data1,
   output o_Data2,
   output o_Data3);

  assign o_Data0 = !i_Sel1 & !i_Sel0 ? i_Data : 1'b0;
  assign o_Data1 = !i_Sel1 &  i_Sel0 ? i_Data : 1'b0;
  assign o_Data2 =  i_Sel1 & !i_Sel0 ? i_Data : 1'b0;
  assign o_Data3 =  i_Sel1 &  i_Sel0 ? i_Data : 1'b0;
endmodule