T2
M98 P"procedures/home-if-not-homed.g"
M98 P"/sys/machine-specific/go-to-cleaning-location.g"
var CurrentTrayAxisPosition = move.axes[4].machinePosition
M591 D5 S1
M83
G91	
if heat.heaters[0].current < global.a_extruder_temp
	M109 S{global.a_extruder_temp}
if global.tray_2_state == 1 & global.tray_0_state == 2
	set global.tray_2_state = -1
	T2
	G1 V-1600 F5000
	G4 S1
	set global.tray_2_state = 0
	echo "#messages.tray.unloadingDone#"^2^"#"
	if global.tray_0_state == 2 & global.multi_material_mode == true
		T0
elif sensors.filamentMonitors[5].status == "NoFilament"
	echo "Filament tray empty"
else
	echo "#messages.tray.unloading#"^2^"#"
	set global.tray_2_state = -1
	T2
	M83
	G1 E10 F800
	G1 E-30 F1500
	G4 S1
	G1 E-60 F1500
	G1 V-55 F2500
	M82
	G1 V-1600 F5000
	G4 S1
	echo "#messages.tray.unloadingDone#"^2^"#"
	set global.tray_2_state = 0
	if global.tray_0_state == 2 & global.multi_material_mode == true
		T0 P0
if sensors.gpIn[7].value == 1
	set global.tray_2_state = 1
	M591 D5 S1
else
	set global.tray_2_state = 0
	M591 D5 S0
G90
G92 V{var.CurrentTrayAxisPosition}
