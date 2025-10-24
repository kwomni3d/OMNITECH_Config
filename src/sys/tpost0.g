if state.status == "processing" &  global.tray_0_state != 2 & global.drives_A_switched == false & global.multi_material_mode == true
	M116 P0
	M98 P"tray/prime_t0.g"
if state.status == "processing"
	M116 P0
if move.axes[2].homed
	G1 R2 Z0
