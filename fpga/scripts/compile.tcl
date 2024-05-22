# This script takes the design in the .xpr project and compile into bitstream
source ./scripts/common.tcl

puts "\n\n---------- Step#1: Record compile start time ----------\n\n" 
set top_module_name top
set checkpoint_dir ${cur_run_dir}/checkpoint
file mkdir ${checkpoint_dir} 
set report_dir ${cur_run_dir}/report
file mkdir ${report_dir}
set netlist_dir ${cur_run_dir}/netlist
file mkdir ${netlist_dir}

puts "\n\n---------- Step#2: Load the sources ----------\n\n" 
# read all the velog source files and Xilinx IPs (currently not using yet)
read_verilog {*}[findFiles ${fpga_root_dir}/src *.v]
# read all the xdc constraint files
read_xdc {*}[findFiles ${fpga_root_dir}/util/constraint *.xdc]

# add pre-defined IPs here when time comes

puts "\n\n---------- Step#3: Start synthesis ----------\n\n" 
synth_design -top ${top_module_name}
write_checkpoint -force ${checkpoint_dir}/${timestamp}_post_synth
report_timing_summary -file ${report_dir}/${timestamp}_post_synth_timing_summary.rpt
report_power -file ${report_dir}/${timestamp}_post_synth_power.rpt
report_clock_interaction -delay_type min_max -file ${report_dir}/${timestamp}_post_synth_clock_interaction.rpt
report_high_fanout_nets -fanout_greater_than 200 -max_nets 50 -file ${report_dir}/${timestamp}_post_synth_high_fanout_nets.rpt

puts "\n\n---------- Step#4: Run placement and logic optimization, report utilization and timing estimates. ----------\n\n" 
opt_design
place_design
phys_opt_design
write_checkpoint -force ${checkpoint_dir}/${timestamp}_post_place
report_timing_summary -file ${report_dir}/${timestamp}_post_place_timing_summary.rpt
# vivado placer generates clockinfo.txt in the directory that vivado is launched, so move it into report directory under current run
# maybe in the future i'll find how to make vivado generate this file somewhere else
file rename -force ${fpga_root_dir}/clockInfo.txt ${cur_run_dir}/report/clockInfo.txt

puts "\n\n---------- Step#5: Run router, report actual utilization and timing. ----------\n\n" 
route_design
write_checkpoint -force ${checkpoint_dir}/${timestamp}_post_route
report_timing_summary -file ${report_dir}/${timestamp}_post_route_timing_summary.rpt
report_timing -max_paths 100 -path_type summary -slack_lesser_than 0 -file ${report_dir}/${timestamp}_post_route_setup_timing_violations.rpt
report_clock_utilization -file ${report_dir}/${timestamp}_clock_util.rpt
report_utilization -file ${report_dir}/${timestamp}_post_route_util.rpt
report_power -file ${report_dir}/${timestamp}_post_route_power.rpt
report_drc -file ${report_dir}/${timestamp}_post_imp_drc.rpt

puts "\n\n---------- Step#6 : Export netlist. Run drc, write verilog and xdc out. ----------\n\n"
write_verilog -force ${netlist_dir}/${proj_name}_netlist.v
write_xdc -no_fixed_only -force ${netlist_dir}/${proj_name}.xdc

puts "\n\n---------- Step#7 : Generate a bitstream ----------\n\n"
write_bitstream -force ${cur_run_dir}/${proj_name}_${timestamp}.bit

exit