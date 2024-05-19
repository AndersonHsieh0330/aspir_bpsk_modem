FPGA_PROJ_ROOT := $(CURDIR)
OUTPUT_DIR := $(FPGA_PROJ_ROOT)/output
PROJ_NAME := spartan7_proj

spartan7_proj.xpr: 
	powershell "Remove-Item -Confirm:$false -Force -Recurse -Path $(FPGA_PROJ_ROOT)/log"
	powershell "mkdir $(FPGA_PROJ_ROOT)/log"
	vivado -mode tcl \
		-source .\scripts\setup.tcl \
		-journal $(OUTPUT_DIR)/log/vivado.jou \
		-log $(OUTPUT_DIR)/log/vivado.log;

compile: $(OUTPUT_DIR)/spartan7_proj.xpr

clean:
	Remove-Item -Confirm:False -Force -Recurse -Path $(OUTPUT_DIR)/*