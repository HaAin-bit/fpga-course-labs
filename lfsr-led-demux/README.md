# LFSR-driven LED selection

`src/Lab_05.v` uses a 22-bit XNOR LFSR, a toggle register and a 1-to-4 demultiplexer. Two inverted switch inputs select the output. Reset is synchronous and active-low. At the 50 MHz clock specified in the SDC, the toggle changes every 4,194,303 clocks (about 83.9 ms) after its first post-reset transition.

## ModelSim test

In a disposable simulation directory, compile `lfsr-led-demux/src/Lab_05.v` and `lfsr-led-demux/tests/lfsr_demux_tb.v` with `vlog -sv`, then run `vsim -c lfsr_demux_tb -do "run -all; quit -f"`. Look for `TEST PASSED` and no errors. The test covers reset, the first LFSR transition, the DEMUX truth table, top-level selection, return to seed after 4,194,303 clocks and the second toggle. It does not record a full waveform.

The switches feed the combinational selector directly; physical bounce and transitions between selections can produce transient output changes. Check clock and I/O constraints against the board. The RTL was developed with AI assistance. Simulation does not establish timing closure or physical board behavior; no new hardware result is claimed.
