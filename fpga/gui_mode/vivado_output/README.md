## Repository Structure
[comment]:< $nbsp is a space character>

guid_mode\
&nbsp;&nbsp;&nbsp;&nbsp;/build\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- all the scripts to create the vivado project\
&nbsp;&nbsp;&nbsp;&nbsp;/ip\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/bd\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- block designs used in vivado\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- all the verilog modules implemented by us\
&nbsp;&nbsp;&nbsp;&nbsp;/src\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- all the code to program the PS side(the ARM core) of zynq-7000
&nbsp;&nbsp;&nbsp;&nbsp;/vivado_output\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- vivado project wrapper will be generated here
.gitignore\
README.md

Do not commit any files in the `/vivado_output` directory to git, as it is specified in `.gitginore`. This is done to keep the rest of the directory clean

## Creating the vivado project and doing work
1. open a powershell terminal
2. `cd` to `/gui_mode` directory
3. execute `/build/build.tcl`
4. you will see a project created in `/vivado_output` directory. `/build/build.tcl` also starts vivado on the project
5. If you need to restart vivado, there will be a `aspir_dsp_model.xpr` file in `/vivado_output`, use vivado to open that