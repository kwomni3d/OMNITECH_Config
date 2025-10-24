T0
M98 P"procedures/home-if-not-homed.g"
M98 P"/sys/machine-specific/go-to-cleaning-location.g"
var CurrentTrayAxisPosition = move.axes[3].machinePosition
G92 U{var.CurrentTrayAxisPosition}
M591 D4 S1
M83
G91
if heat.heaters[0].current < global.a_extruder_temp
	M109 S{global.a_extruder_temp}
if global.tray_0_state == 1 & global.tray_2_state == 2
	set global.tray_0_state = -1
	T0
	G1 U-1600 F5000
	G4 S1
	set global.tray_0_state = 0
	echo "#messages.tray.unloadingDone#"^0^"#"
	if global.tray_2_state == 2 & global.multi_material_mode == true
		T2
elif sensors.filamentMonitors[4].status == "NoFilament"
	echo "Filament tray empty"
else
	echo "#messages.tray.unloading#"^0^"#"
	set global.tray_0_state = -1
	T0
	M83
	G1 E10 F800
	G1 E-30 F1500
	G4 S1
	G1 E-60 F1500
	G1 U-55 F2500
	M82
	G1 U-1600 F5000
	G4 S1
	echo "#messages.tray.unloadingDone#"^0^"#"
	set global.tray_0_state = 0
	if global.tray_2_state == 2 & global.multi_material_mode == true
		T2 P0	
if sensors.gpIn[6].value == 1
	set global.tray_0_state = 1
	M591 D4 S1
else
	set global.tray_0_state = 0
	M591 D4 S0
G90
G92 U{var.CurrentTrayAxisPosition}
