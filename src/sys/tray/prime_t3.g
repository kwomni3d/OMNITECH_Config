T3
M98 P"procedures/home-if-not-homed.g"
M98 P"/sys/machine-specific/go-to-cleaning-location.g"
M98 P"tray/probe_t3.g"
M591 D3 S0
M83
G91
if global.tray_3_state == 2
	echo "#messages.tray.primingDone#"^3^"#"
elif global.tray_3_state != 0
	echo "#messages.tray.priming#"^3^"#"
	if heat.heaters[1].current < global.b_extruder_temp
		M109 S{global.b_extruder_temp}
	if global.tray_1_state == 2
		set global.tray_1_state = -1
		T1 P0
		M83
		G1 E10 F300
		G4 S2
		G1 E-360 F2500
		G4 S2
		set global.tray_1_state = 1	
	elif global.tray_3_state == 1 & global.e1_position_known == false
		set global.tray_3_state = -1
		T1 P0
		M83
		G1 E10 F300
		G4 S1
		G1 E-360 F1500
		G4 S1
		set global.tray_3_state = 1
	T3 P0
	M98 P"/sys/machine-specific/go-to-cleaning-location.g"
	set global.tray_3_state = -1
	var success = false
	while iterations < 40
		G1 E40 F2000
		if sensors.gpIn[11].value == 1
			G1 E90 F700
			G1 E40 F700
			M98 P"/sys/machine-specific/clean.g"
			M400
			set var.success = true
			break
	if var.success == true
		set global.tray_3_state = 2
		set global.e1_position_known = true
		echo "#messages.tray.primingDone#"^1^"#"
	elif var.success == false
		set global.tray_3_state = 1
		echo "#messages.tray.primingError#"^3^"#"
M591 D3 S1
G90
