### Project Mode vs Non-Project Mode
There are two modes that vivado projects can be structured in, project mode is more guided where as non-project mode the designer has full control on the files and everything has to be done by scripting. <br />
In our case I've decided to use non-project mode with makefile and tcl scripting because I want everything to be able to be done with a few commands. Also I want full control of the files generated.
For more detail please see "Vivado Design Flow Overview" ([UG892](https://docs.amd.com/r/en-US/ug892-vivado-design-flows-overview))

### Scripting : common.tcl
sets some project wide Tcl variables and Tcl procedures.

### Scripting : compile.tcl
Loads all the verilog sources, .xdc constraint files, then run the synthesis and place&route with some optimizations inbetween. The output of this script is a bitstream with the file name <project_name>_<compilation_timestamp>.bit sitting in `/output/<compilation_timestamp>` folder

### Scripting : setup.tcl (Deprecated)
Create a project and apply relevant settings like specifying which fpga we're programming, adding source/constraint files, etc. <br /> 
The most important file this script generates is the <project_name>.xpr file. This file contains all the information about our project. Some folders are also generated for vivado to manage our sources like the <project_name>.cache, <project_name>.hw, <project_name>.ip_user_files. This is because we're using project mode and vivado does some more work to manage our project.

### vivado checkpoints (.dcp)
These are files that we can open with vivado gui to get a visualization of the placement nets and cells. This can be pretty helpful during debugging and timing closure when we need to manually change the placement ad routing.

### Some Useful Links
- [Useful Tcl scripting example](https://github.com/hdlguy/vivado_tcl/tree/master)
- [Non-Project mode scripting example](https://github.com/kdurant/vivado_non_project_example/tree/master)
- [More detailed non-project mode scripting example : partial reconfiguration](https://github.com/lastweek/fpga_pr_scripts)