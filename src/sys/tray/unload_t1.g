T1
M98 P"procedures/home-if-not-homed.g"
M98 P"/sys/machine-specific/go-to-cleaning-location.g"
var CurrentTrayAxisPosition = move.axes[5].machinePosition
G92 W{var.CurrentTrayAxisPosition}
M591 D2 S1
M83
G91
if heat.heaters[1].current < global.b_extruder_temp
	M109 S{global.b_extruder_temp}
if global.tray_1_state == 1 & global.tray_3_state == 2
	set global.tray_1_state = -1
	T1
	G1 W-1600 F5000
	G4 S1
	set global.tray_1_state = 0
	echo "#messages.tray.unloadingDone#"^1^"#"
	if global.tray_3_state == 2 & global.multi_material_mode == true
		T3
elif sensors.filamentMonitors[2].status == "NoFilament"
	echo "Filament tray empty"
else
	echo "#messages.tray.unloading#"^1^"#"
	set global.tray_1_state = -1
	T1		
	M83
	G1 E10 F800		
	G1 E-30 F1500
	G4 S1
	G1 E-60 F1500
	G1 W-55 F2500
	M82
	G1 W-1600 F5000
	G4 S1
	echo "#messages.tray.unloadingDone#"^1^"#"
	set global.tray_1_state = 0
	if global.tray_3_state == 2 & global.multi_material_mode == true
		T3 P0
if sensors.gpIn[10].value == 1
	set global.tray_1_state = 1
	M591 D2 S1
else
	set global.tray_1_state = 0
	M591 D2 S0
G90
G92 W{var.CurrentTrayAxisPosition}
