
# PlanAhead Launch Script for Pre-Synthesis Floorplanning, created by Project Navigator

create_project -name RPG -dir "X:/Desktop/EC 551 Labs/RPG_GAME_FPGA-master/RPG/planAhead_run_1" -part xc6slx16csg324-3
set_param project.pinAheadLayout yes
set srcset [get_property srcset [current_run -impl]]
set_property target_constrs_file "vga_controller.ucf" [current_fileset -constrset]
add_files [list {ipcore_dir/Ash.ngc}]
add_files [list {ipcore_dir/Grass.ngc}]
add_files [list {ipcore_dir/Enemy.ngc}]
add_files [list {ipcore_dir/flower.ngc}]
add_files [list {ipcore_dir/brick.ngc}]
set hdlfile [add_files [list {ipcore_dir/Grass.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {ipcore_dir/Grass_synth.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {ipcore_dir/flower_synth.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {ipcore_dir/flower.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {ipcore_dir/brick_synth.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {ipcore_dir/brick.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {collisionDetection.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {Sprite_Sel.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {Ranger.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {Move_Module.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {Keyboard_PS2.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {ipcore_dir/Enemy_synth.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {ipcore_dir/Enemy.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {ipcore_dir/Ash.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {ipcore_dir/Ash_synth.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {fonr_rom.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {clk_div.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {clk_250ms.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {Background.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {vga.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {start_screen.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {GameTop.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set_property top GameTop $srcset
add_files [list {vga_controller.ucf}] -fileset [get_property constrset [current_run]]
add_files [list {ipcore_dir/Ash.ncf}] -fileset [get_property constrset [current_run]]
add_files [list {ipcore_dir/Enemy.ncf}] -fileset [get_property constrset [current_run]]
add_files [list {ipcore_dir/Grass.ncf}] -fileset [get_property constrset [current_run]]
add_files [list {ipcore_dir/flower.ncf}] -fileset [get_property constrset [current_run]]
add_files [list {ipcore_dir/house.ncf}] -fileset [get_property constrset [current_run]]
add_files [list {ipcore_dir/brick.ncf}] -fileset [get_property constrset [current_run]]
open_rtl_design -part xc6slx16csg324-3
