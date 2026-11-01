module Debounce_Project_Top
  (input  i_Clk,
   input  i_Switch_1,
   output o_LED_1);

  wire w_Debounced_Switch;

  Debounce_Filter
    #(.DEBOUNCE_LIMIT(250000)) Debounce_Inst
    (.i_Clk(i_Clk),
     .i_Bouncy(i_Switch_1),
     .o_Debounced(w_Debounced_Switch));

  LED_Toggle_Project LED_Toggle_Inst
    (.i_Clk(i_Clk),
     .i_Switch_1(w_Debounced_Switch),
     .o_LED_1(o_LED_1));
endmodule


module Debounce_Filter #(parameter DEBOUNCE_LIMIT = 20) (
  input  i_Clk,
  input  i_Bouncy,
  output o_Debounced);
  // Synchronize the asynchronous, active-low button before filtering.
  reg r_Sync_1 = 1'b1;
  reg r_Sync_2 = 1'b1;
  always @(posedge i_Clk) begin
    r_Sync_1 <= i_Bouncy;
    r_Sync_2 <= r_Sync_1;
  end

  // Keep a legal register width when DEBOUNCE_LIMIT is 1.
  localparam COUNT_WIDTH = (DEBOUNCE_LIMIT <= 1) ? 1 : $clog2(DEBOUNCE_LIMIT);
  reg [COUNT_WIDTH-1:0] r_Count = 0;
  reg r_State = 1'b1;
  always @(posedge i_Clk)
  begin
    if (r_Sync_2 == r_State)
      r_Count <= 0;
    else if (r_Count == DEBOUNCE_LIMIT-1) begin
      r_State <= r_Sync_2;
      r_Count <= 0;
    end else
      r_Count <= r_Count + 1'b1;
  end
  assign o_Debounced = r_State;
endmodule

module LED_Toggle_Project(
  input  i_Clk,
  input  i_Switch_1,
  output o_LED_1);

  reg r_LED_1    = 1'b0;
  reg r_Switch_1 = 1'b1;


  always @(posedge i_Clk)
  begin
    r_Switch_1 <= i_Switch_1;
    if (i_Switch_1 == 1'b1 && r_Switch_1 == 1'b0)
    begin
      r_LED_1 <= ~r_LED_1;
    end
  end

  assign o_LED_1 = r_LED_1;
endmodule
