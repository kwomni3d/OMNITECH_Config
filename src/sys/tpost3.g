if  state.status == "processing" & global.tray_3_state != 2 & global.drives_B_switched == false & global.multi_material_mode == true
	M116 P3
	M98 P"tray/prime_t3.g"
if state.status == "processing"
	M116 P0
if move.axes[2].homed
	G1 R2 Z0