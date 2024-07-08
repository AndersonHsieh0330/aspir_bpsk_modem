GUI_MODE_ROOT := $(CURDIR)
VIVADO_OUTPUT_DIR := $(GUI_MODE_ROOT)/vivado_output
SCRIPT_DIR := $(GUI_MODE_ROOT)/script
PROJECT_NAME := aspir_dsp_modem

create_project: $(SCRIPT_DIR)/create_project.tcl
	echo "\nexit" >> $(SCRIPT_DIR)/create_project.tcl
	vivado -mode tcl \
		-source $(SCRIPT_DIR)/create_project.tcl \
		-journal $(VIVADO_OUTPUT_DIR)/vivado_create_project.jou \
		-log $(VIVADO_OUTPUT_DIR)/vivado_create_project.log

start_vivado: $(VIVADO_OUTPUT_DIR)/$(PROJECT_NAME).xpr
	vivado -mode gui \
		-journal $(VIVADO_OUTPUT_DIR)/vivado.jou \
		-log $(VIVADO_OUTPUT_DIR)/vivado.log \
		$^ &

.PHONY: clean start_vivado

clean:
	rm -rf $(VIVADO_OUTPUT_DIR)/*
