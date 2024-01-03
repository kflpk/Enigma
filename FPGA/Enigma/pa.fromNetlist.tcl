
# PlanAhead Launch Script for Post-Synthesis floorplanning, created by Project Navigator

create_project -name Enigma -dir "/home/kacper/Programs/Enigma/FPGA/Enigma/planAhead_run_3" -part xc6slx16csg324-3
set_property design_mode GateLvl [get_property srcset [current_run -impl]]
set_property edif_top_file "/home/kacper/Programs/Enigma/FPGA/Enigma/EN_top.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {/home/kacper/Programs/Enigma/FPGA/Enigma} }
set_property target_constrs_file "Nexys3_master.ucf" [current_fileset -constrset]
add_files [list {Nexys3_master.ucf}] -fileset [get_property constrset [current_run]]
link_design
