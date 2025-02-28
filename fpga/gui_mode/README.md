## Installation Prereq
### Windows 
- Windows 11
- [Vivado 2019.1](https://www.xilinx.com/member/forms/download/xef-vivado.html?filename=Xilinx_Vivado_SDK_2019.1_0524_1430.tar.gz)
### WSL Linux (deprecated)
- WSL Ubuntu 22.04.3 LTS (This ubuntu version is supported by Xilinx for vivado and vitis)
- [Vivado 2024.1](https://www.xilinx.com/support/download.html)
- GNU Make
- [usbipd](https://learn.microsoft.com/en-us/windows/wsl/connect-usb) installed on the windows side (if you need to program the SoC)

## Repository Structure
[comment]:< $nbsp is a space character>

/guid_mode\
&nbsp;&nbsp;&nbsp;&nbsp;/script\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- all the scripts to create the vivado project\
&nbsp;&nbsp;&nbsp;&nbsp;/bd\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- directory that stores the block design files\
&nbsp;&nbsp;&nbsp;&nbsp;/constrs\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- all the .xdc constraints files\
&nbsp;&nbsp;&nbsp;&nbsp;/ip_repo\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- all the packaged ip directories, including the top module wrapper verilog file that instantiates the actual rtl logic, which is in the /ip folder\
&nbsp;&nbsp;&nbsp;&nbsp;/ip\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- all the verilog modules implemented by us\
&nbsp;&nbsp;&nbsp;&nbsp;/src\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- all the code to program the PS side(the ARM core) of zynq-7000\
&nbsp;&nbsp;&nbsp;&nbsp;/test\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- all the firmware related test files\
&nbsp;&nbsp;&nbsp;&nbsp;/rtl_test\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- all the RTL related test files\
&nbsp;&nbsp;&nbsp;&nbsp;/vivado_output\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- vivado project wrapper will be generated here\
&nbsp;&nbsp;&nbsp;&nbsp;.gitignore\
&nbsp;&nbsp;&nbsp;&nbsp;README.md

Do not commit any files in the `/vivado_output` directory to git, as it is specified in `.gitginore`. This is done to keep the rest of the directory clean

## The workflow
### Windows
1. open windows powershell and cd to /gui_mode directory
2. execute the following commands 
```
. ./windows_make.ps1
create_project
start_vivado
```
3. when you ready to commit the project to version control, execute the following command in the tcl console in vivado GUI. This will export the project as a tcl script that can recreate the project, this file exists in `/script/create_project.tcl`
```
source ./scripts/save_project_state
save_project_state
```
4. in the `/gui_mode` directory, execute `git add .` and `git commit` to add ur files. The `.gitignore` file has already specified what should be committed and what shouldn't.

### WSL Linux (deprecated)
1. `cd` to `/gui_mode` directory
2. execute `make create_project` target to create vivado project under `/vivado_output` directory.
3. execute `make start_vivado` target to open the created project in vivado gui mode.
4. do your thing and change the project however you want.
5. when you ready to commit the project to version control, execute the following command in the tcl console in vivado GUI. This will export the project as a tcl script that can recreate the project, this file exists in `/script/create_project.tcl`
```
source ./scripts/save_project_state
save_project_state
```
6. in the `/gui_mode` directory, execute `git add .` and `git commit` to add ur files. The `.gitignore` file has already specified what should be committed and what shouldn't.
