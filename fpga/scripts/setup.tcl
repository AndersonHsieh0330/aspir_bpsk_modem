# setup a vivado project, output a .xpr file

# remove all files in output directory
# {*} expands the list of files into individual command arguments
set fpga_root_dir [pwd]
set proj_name "spartan7_proj"
set proj_dir ${fpga_root_dir}/output/${proj_name}_root
set files_in_proj_dir [glob -nocomplain -directory "${proj_dir}" *]
if {[llength $files_in_proj_dir] > 0} {
    file delete -force {*}$files_in_proj_dir
}

create_project -part xc7s50csga324-1 ${proj_name} ${proj_dir}

# set project properties
set proj_obj [current_project]
# points vivado to the dowloaded boardfiles in util/arty_s7_50_boardfiles
set_property -name "board_part_repo_paths" -value "[file normalize "${fpga_root_dir}/util/arty_s7_50_boardfiles"]" -objects $proj_obj
set_property -name "board_part" -value "digilentinc.com:arty-s7-50:part0:1.1" -objects $proj_obj
set_property -name "default_lib" -value "work" -objects $proj_obj
set_property target_language Verilog [current_project] -objects $proj_obj

# adding verilog sources
create_fileset -srcset rtl_src_fileset
set rtl_src_fileset_obj [get_filesets rtl_src_fileset]
set rtl_src_files [glob -directory "${fpga_root_dir}/src" *]
add_files -norecurse -fileset ${rtl_src_fileset_obj} ${rtl_src_files}

# adding contraints files
# we can have multiple constraint files for each i/o bank
create_fileset -constrset constraint_fileset
set constraint_fileset_obj [get_filesets constraint_fileset]
set constraint_files [glob -directory "${fpga_root_dir}/util/constraint" *.xdc]
add_files -norecurse -fileset ${constraint_fileset_obj} ${constraint_files}

# set properties on constraint files
set constraint_files_obj [get_files -of_objects [get_filesets constraint_fileset] [list {*}${constraint_files}]]
set_property -name "file_type" -value "XDC" -objects $constraint_files_obj

close_project
exit