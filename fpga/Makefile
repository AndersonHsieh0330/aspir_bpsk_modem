# note that the default shell is sh.exe, make sure you have it in your windows system
FPGA_ROOT := $(CURDIR)
OUTPUT_DIR := $(FPGA_ROOT)/output
SCRIPTS_DIR := $(FPGA_ROOT)/scripts
PROJ_NAME := spartan7_proj

spartan7_proj.xpr:
	mkdir -p $(OUTPUT_DIR)/log
	vivado -mode tcl \
		-source $(SCRIPTS_DIR)/setup.tcl \
		-journal $(OUTPUT_DIR)/log/vivado_$(shell date '+%Y-%m-%d_%H-%M-%S').jou \
		-log $(OUTPUT_DIR)/log/vivado_$(shell date '+%Y-%m-%d_%H-%M-%S').log

compile: $(OUTPUT_DIR)/spartan7_proj.xpr

clean:
	rm -rf $(OUTPUT_DIR)/*
