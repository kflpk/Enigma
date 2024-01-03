
# PlanAhead Launch Script for Pre-Synthesis Floorplanning, created by Project Navigator

create_project -name Enigma -dir "/home/kacper/Programs/Enigma/FPGA/Enigma/planAhead_run_2" -part xc6slx16csg324-3
set_param project.pinAheadLayout yes
set srcset [get_property srcset [current_run -impl]]
set_property target_constrs_file "Nexys3_master.ucf" [current_fileset -constrset]
set hdlfile [add_files [list {EN_top.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set_property top EN_top $srcset
add_files [list {Nexys3_master.ucf}] -fileset [get_property constrset [current_run]]
open_rtl_design -part xc6slx16csg324-3
