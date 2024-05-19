# setup a vivado project, output a .xpr file

# remove all files in output directory
# {*} expands the list of files into individual command arguments
file delete -force {*}[glob -directory "output" *]

create_project -part xc7s50csga324-1 spartan7_proj
set_property target_language Verilog [current_project]
