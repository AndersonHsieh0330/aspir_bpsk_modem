proc save_project_state {} {
    # the use of -no_copy_sources and -use_bd_files makes the generated project reference the design files that are checked into git
    # instead of copying/regenerated them depending on if its verilog or block design files respectively
    # note that when a project contains block design, -no_copy_source can not be used without -use_bd_files
    write_project_tcl -paths_relative_to ./ -origin_dir_override ./ -target_proj_dir ./vivado_output -force -all_properties -no_copy_sources -use_bd_files -internal ./script/create_project.tcl
}