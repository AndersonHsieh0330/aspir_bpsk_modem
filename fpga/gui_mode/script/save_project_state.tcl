proc save_project_state {} {
    write_project_tcl -paths_relative_to ./ -origin_dir_override ./ -target_proj_dir ./vivado_output -force -all_properties -no_copy_sources -internal ./script/create_project.tcl
}