# FPGA course labs

Selected lab artifacts from the **FPGA Programming** course. This repository contains source Verilog, pin constraints, timing constraint files, and Gowin project descriptors. It excludes installed software, vendor examples, generated build files, and coursework handouts.

| Lab | What the source contains | Evidence currently available |
| --- | --- | --- |
| [Button debounce and LED toggle](button-debounce/) | Debounce filter and LED toggle modules | Source, Gowin project files and a self-checking simulation testbench; no independent board result documented |
| [LFSR and LED demultiplexer](lfsr-led-demux/) | 22-bit LFSR feeding LED selection through a 1-to-4 demultiplexer | Source, Gowin project files and a self-checking simulation testbench; no independent board result documented |
| [Memory game](memory-game/) | Fixed 7-step LED sequence, button handling, FSM, and seven-segment output | Source and Gowin project files; course participant confirmed programming and observing the design on a physical board |

All three project files target **Gowin GW5A-25A** (`GW5A-LV25UG324C2/I1`). The included constraints match the course board and should be checked against another board's schematic before programming. The source code was developed with AI assistance; inclusion here records course work and the deployment workflow, not a claim of independently authoring every RTL module.

## Reproduce

Open the `.gprj` file for one lab in Gowin IDE. Confirm the top module and device, inspect `src/*.cst` against the board, then run synthesis and placement/routing. Only program hardware after checking pinout and I/O voltage. Check each clock constraint against the actual board clock. The memory-game `.sdc` remains empty.

## Scope

The memory-game lab was demonstrated on physical hardware. For the other two labs, this portfolio currently provides inspectable project artifacts; no hardware validation or performance numbers are claimed. If later tested, record the board, steps, result, and date in the corresponding lab README.
