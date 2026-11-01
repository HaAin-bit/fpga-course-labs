`timescale 1ns/1ps
module debounce_tb;
  reg clk = 0;
  reg button = 1;
  wire filtered, led;
  integer failures = 0;
  always #10 clk = ~clk;

  Debounce_Filter #(.DEBOUNCE_LIMIT(4)) filter (
    .i_Clk(clk), .i_Bouncy(button), .o_Debounced(filtered));
  LED_Toggle_Project toggle (
    .i_Clk(clk), .i_Switch_1(filtered), .o_LED_1(led));

  task check;
    input expected_filter, expected_led;
    begin
      if (filtered !== expected_filter || led !== expected_led) begin
        $display("FAIL t=%0t filtered=%b led=%b expected=%b%b", $time,
                 filtered, led, expected_filter, expected_led);
        failures = failures + 1;
      end
    end
  endtask

  task ticks;
    input integer count;
    begin repeat (count) @(negedge clk); end
  endtask

  initial begin
    ticks(5); check(1, 0); // no phantom toggle at startup
    button = 0; ticks(2); button = 1; ticks(8); check(1, 0); // short bounce
    button = 0; ticks(10); check(0, 0); // stable press, no rising edge
    button = 1; ticks(10); check(1, 1); // release toggles once
    ticks(10); check(1, 1); // held state cannot toggle again
    button = 0; ticks(10); check(0, 1);
    button = 1; ticks(10); check(1, 0); // second release toggles back
    if (failures != 0) begin
      $display("TEST FAILED: %0d errors", failures);
      $fatal(1);
    end
    $display("TEST PASSED: debounce and LED toggle");
    $finish;
  end
endmodule
