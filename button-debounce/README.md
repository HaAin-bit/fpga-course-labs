# Button debounce and LED toggle

`src/Lab_04.v` synchronizes the button through two flip-flops, accepts a new level after 250,000 consecutive samples, and toggles the LED on the filtered rising edge. The input is initialized high for the original pull-up wiring; with a button wired to ground, the LED toggles on release. Confirm button and LED polarity against the board schematic.

`src/Lab_04.sdc` assumes a 50 MHz input clock (20 ns): verify the board clock before using it. At 50 MHz the filter accepts a new level after 5 ms, plus synchronization latency. `DEBOUNCE_LIMIT` must be a positive integer. This design uses FPGA register initialization rather than an external reset.

## ModelSim test

From the repository root in a disposable simulation directory, compile `button-debounce/src/Lab_04.v` and `button-debounce/tests/debounce_tb.v` with `vlog -sv`, then run `vsim -c debounce_tb -do "run -all; quit -f"`. Check for `TEST PASSED` and no `FAIL` lines. The test exercises startup, a short pulse, stable press/release, and repeated operation with a reduced debounce limit.

The RTL was developed with AI assistance. Simulation does not verify metastability behavior, pin mapping, timing closure, or operation on physical hardware; no new board result is claimed.
