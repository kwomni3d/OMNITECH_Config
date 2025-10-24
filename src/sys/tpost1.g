if  state.status == "processing" & global.tray_1_state != 2 & global.drives_B_switched == false & global.multi_material_mode == true
	M116 P1
	M98 P"tray/prime_t1.g"
if state.status == "processing"
	M116 P1
if move.axes[2].homed
	G1 R2 Z0	