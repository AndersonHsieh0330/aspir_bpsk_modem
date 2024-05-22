# note that the default shell is sh.exe, make sure you have it in your windows system
FPGA_ROOT := $(CURDIR)
OUTPUT_DIR := $(FPGA_ROOT)/output
SCRIPTS_DIR := $(FPGA_ROOT)/scripts
TIMESTAMP_FILE := $(OUTPUT_DIR)/timestamp.txt
PROJ_NAME := spartan7_proj
RUN :=

.PHONY: clean compile $(OUTPUT_DIR)/timestamp.txt setup

$(OUTPUT_DIR)/timestamp.txt: 
# This file has the timestamp of when vivado was started
# The timestamp is used by vivado tcl script to name the runs
	$(eval TIMESTAMP := $(shell date '+%Y-%m-%d_%H-%M-%S'))
	echo -n $(TIMESTAMP) > $(TIMESTAMP_FILE)

# create the log folder under current run directory if doesn't exist
$(OUTPUT_DIR)/log: $(OUTPUT_DIR)/timestamp.txt
	mkdir -p $(OUTPUT_DIR)/$(TIMESTAMP)/log

compile: $(OUTPUT_DIR)/log
	vivado -mode tcl \
		-source $(SCRIPTS_DIR)/compile.tcl \
		-journal $(OUTPUT_DIR)/$(TIMESTAMP)/log/vivado_compile_$(TIMESTAMP).jou \
		-log $(OUTPUT_DIR)/$(TIMESTAMP)/log/vivado_compile_$(TIMESTAMP).log

program_fpga:
ifdef RUN
# a run bitstream is specified
ifneq ("$(wildcard $(OUTPUT_DIR)/$(RUN)/$(PROJ_NAME)_$(RUN).bit)", "")
	vivado -mode tcl \
		-source $(SCRIPTS_DIR)/program_fpga.tcl \
		-journal $(OUTPUT_DIR)/$(RUN)/log/vivado_program_fpga_$(RUN).jou \
		-log $(OUTPUT_DIR)/$(RUN)/log/vivado_program_fpga_$(RUN).log
else 
# bitstream with the timestamp $(RUN) doesn't exist, output error
	echo "bitstream with timestamp $(RUN) doesn't exist"
endif 
else 
# a run bitstream is not specified, default to the last run which is in /output/timestamp.txt
# note that the vivado log and journal that this generates will have the timestamp of when the programming is ran
# but the log/journal file itself will sit in the /log folder of the compilation run with the compilation timestamp
	vivado -mode tcl \
		-source $(SCRIPTS_DIR)/program_fpga.tcl \
		-journal $(OUTPUT_DIR)/$(shell cat $(TIMESTAMP_FILE))/log/vivado_program_fpga_$(shell date '+%Y-%m-%d_%H-%M-%S').jou \
		-log $(OUTPUT_DIR)/$(shell cat $(TIMESTAMP_FILE))/log/vivado_program_fpga_$(shell date '+%Y-%m-%d_%H-%M-%S').log
endif

clean:
	rm -rf $(OUTPUT_DIR)/* 

# deprecated 
# don't call this target, we're not using vivado project mode no more
setup: $(OUTPUT_DIR)/log
	vivado -mode tcl \
		-source $(SCRIPTS_DIR)/setup.tcl \
		-journal $(OUTPUT_DIR)/$(TIMESTAMP)/log/vivado_setup_$(TIMESTAMP).jou \
		-log $(OUTPUT_DIR)/$(TIMESTAMP)/log/vivado_setup_$(TIMESTAMP).log
