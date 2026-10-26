# FPGA memory game

Course lab for a fixed seven-step memory game. `src/Lab_06.v` contains button synchronization and debounce logic, a finite-state controller, LED output, and seven-segment display logic. The Gowin project targets GW5A-25A.

**Confirmed participant contribution:** Created the Gowin project, assigned I/O pins, ran synthesis, programmed the FPGA, and demonstrated the game on a physical board. A video exists according to the participant but is not included here. RTL was generated with AI assistance. No claim is made of independently designing the RTL or writing a testbench.

**To reproduce:** Open `Lab_06.gprj`, check the pin map in `src/Lab_06.cst`, run Gowin's build flow, and program only a compatible board. The clock is mapped to pin `T9` in the original constraints; verify board compatibility before reuse.
