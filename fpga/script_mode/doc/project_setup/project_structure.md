### What Goes In Each Folder Under `/fpga`
- `/doc` - all the documentation.
- `/output` - any files generated by the flow, everything in this folder is .gitignored.
- `/scripts` - any automating scripts, including the vivado tcl scripts.
- `/src` - all the verilog source files.
- `/util` - miscellaneous files like the fpga contraint file(.xdc), arty s7-50 board file, etc.
- note that vivado also generates this `/.Xil` folder for temporary files, it is also .gitignored