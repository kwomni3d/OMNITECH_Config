if state.status == "processing" & global.tray_2_state != 2 & global.drives_A_switched == false & global.multi_material_mode == true
	M116 P2
	M98 P"tray/prime_t2.g"
if state.status == "processing"
	M116 P1
if move.axes[2].homed
	G1 R2 Z0