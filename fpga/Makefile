# note that the default shell is sh.exe, make sure you have it in your windows system
FPGA_ROOT := $(CURDIR)
OUTPUT_DIR := $(FPGA_ROOT)/output
SCRIPTS_DIR := $(FPGA_ROOT)/scripts
TIMESTAMP_FILE := $(OUTPUT_DIR)/timestamp.txt
PROJ_NAME := spartan7_proj

.PHONY: clean compile

$(OUTPUT_DIR)/timestamp.txt: 
# This file has the timestamp of when vivado was started
# The timestamp is used by vivado tcl script to name the runs
	$(eval TIMESTAMP := $(shell date '+%Y-%m-%d_%H-%M-%S'))
	echo -n $(TIMESTAMP) >> $(TIMESTAMP_FILE)

$(OUTPUT_DIR)/log: $(OUTPUT_DIR)/timestamp.txt
	mkdir -p $(OUTPUT_DIR)/$(TIMESTAMP)/log

compile: $(OUTPUT_DIR)/log
	vivado -mode tcl \
		-source $(SCRIPTS_DIR)/compile.tcl \
		-journal $(OUTPUT_DIR)/$(TIMESTAMP)/log/vivado_$(TIMESTAMP).jou \
		-log $(OUTPUT_DIR)/$(TIMESTAMP)/log/vivado_$(TIMESTAMP).log

clean:
	rm -rf $(OUTPUT_DIR)/* 

# deprecated 
# don't call this target, we're not using vivado project mode no more
spartan7_proj.xpr: $(OUTPUT_DIR)/log
	vivado -mode tcl \
		-source $(SCRIPTS_DIR)/setup.tcl \
		-journal $(OUTPUT_DIR)/$(TIMESTAMP)/log/vivado_$(TIMESTAMP).jou \
		-log $(OUTPUT_DIR)/$(TIMESTAMP)/log/vivado_$(TIMESTAMP).log
