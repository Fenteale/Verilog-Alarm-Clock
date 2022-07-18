# Verilog-Alarm-Clock

A simple alarm clock written in Verilog. This was designed and tested with the Xilinx Nexys-A7 FPGA development board.

This project is designed to be setup via the tcl scripts provided for Vivado.

- `add_files.tcl` adds all the source files to the project.
- `build_bitstream.tcl` synthesises and places design. It also then builds a bitstream file to be flashed onto the FPGA board.
- `program.tcl` programs the attached FPGA board from the previously generated bitstream file.