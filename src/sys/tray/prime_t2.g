T2
M98 P"procedures/home-if-not-homed.g"
M98 P"/sys/machine-specific/go-to-cleaning-location.g"
M98 P"tray/probe_t2.g"
M591 D5 S0
M83
G91
if global.tray_2_state == 2
	echo "#messages.tray.primingDone#"^2^"#"
elif global.tray_2_state != 0
	echo "#messages.tray.priming#"^2^"#"
	if heat.heaters[0].current < global.a_extruder_temp
		M109 S{global.a_extruder_temp}
	if global.tray_0_state == 2
		set global.tray_0_state = -1
		T0 P0
		M83
		G1 E10 F300
		G4 S2
		G1 E-360 F2500
		G4 S2
		set global.tray_0_state = 1	
	elif global.tray_0_state == 1 & global.e0_position_known == false
		set global.tray_0_state = -1
		T0 P0
		M83
		G1 E10 F300
		G4 S2
		G1 E-360 F2500
		G4 S2
		set global.tray_0_state = 1	
	T2 P0
	M98 P"/sys/machine-specific/go-to-cleaning-location.g"
	set global.tray_2_state = -1
	var success = false
	while iterations < 40
		G1 E40 F3000
		if sensors.gpIn[8].value == 1
			G1 E90 F1500
			G1 E40 F700
			M98 P"/sys/machine-specific/clean.g"
			M400
			set var.success = true
			break
	if var.success == true
		set global.tray_2_state = 2
		set global.e0_position_known = true
		echo "#messages.tray.primingDone#"^2^"#"
	elif var.success == false
		set global.tray_2_state = 1
		echo "#messages.tray.primingError#"^2^"#"
M591 D5 S1
G90
