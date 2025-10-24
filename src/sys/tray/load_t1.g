G91
var CurrentTrayAxisPosition = move.axes[5].machinePosition
if global.tray_1_state == 0
	echo "#messages.tray.loading#"^1^"#"
	G91
	set global.tray_1_state = -1
	G1 W1000 F3000
	G4 S2
	if sensors.filamentMonitors[2].status == "ok"
		echo "#messages.tray.loadingDone#"^1^"#"
		set global.tray_1_state = 1
		G90
	else
		set global.tray_1_state = 0
M591 D2 S1
if sensors.filamentMonitors[2].status == "ok"
	set global.tray_1_state = 1
else
	set global.tray_1_state = 0
G90
G92 W{var.CurrentTrayAxisPosition}
