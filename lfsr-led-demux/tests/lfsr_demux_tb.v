`timescale 1ns/1ps
module lfsr_demux_tb;
  reg clk=0, rst=0, sw1=1, sw2=1;
  wire led1, led2, led3, led4;
  reg data=0;
  reg [1:0] sel=0;
  wire [3:0] d;
  integer i, v;
  always #10 clk=~clk;
  Demux_LFSR_Project_Top dut(clk,rst,sw1,sw2,led1,led2,led3,led4);
  Demux_1_To_4 demux(data,sel[1],sel[0],d[0],d[1],d[2],d[3]);
  task check;
    input condition;
    input [255:0] message;
    begin
      if (condition !== 1'b1) begin
        $display("FAIL: %0s, time=%0t",message,$time);
        $fatal(1);
      end
    end
  endtask
  initial begin
    // Exercise each selector for both possible data values.
    for (v=0; v<2; v=v+1) begin
      for (i=0; i<4; i=i+1) begin
        data=v; sel=i; #1;
        check(d === (v ? (4'b0001 << i) : 4'b0000), "demux truth table");
      end
    end
    // Reset asserted at a clock edge, then released away from edges.
    @(posedge clk); #1;
    check(dut.LFSR_Inst.r_LFSR === 22'd1 && dut.r_LFSR_Toggle === 1'b0, "reset");
    @(negedge clk); rst=1;
    @(posedge clk); #1;
    check(dut.LFSR_Inst.r_LFSR === 22'd3 && dut.r_LFSR_Toggle === 1'b1, "first step and toggle");
    // Top-level selectors invert the physical inputs.
    sw2=1; sw1=1; #1; check({led4,led3,led2,led1} === 4'b0001, "top select 00");
    sw2=1; sw1=0; #1; check({led4,led3,led2,led1} === 4'b0010, "top select 01");
    sw2=0; sw1=1; #1; check({led4,led3,led2,led1} === 4'b0100, "top select 10");
    sw2=0; sw1=0; #1; check({led4,led3,led2,led1} === 4'b1000, "top select 11");
    repeat (4194302) @(posedge clk);
    #1;
    check(dut.LFSR_Inst.r_LFSR === 22'd1 && dut.w_LFSR_Done === 1'b1 && dut.r_LFSR_Toggle === 1'b1, "seed return");
    @(posedge clk); #1;
    check(dut.LFSR_Inst.r_LFSR === 22'd3 && dut.r_LFSR_Toggle === 1'b0, "second toggle");
    check({led4,led3,led2,led1} === 4'b0000, "zero data through top");
    $display("TEST PASSED: LFSR cycle, toggle and DEMUX");
    $finish;
  end
endmodule
