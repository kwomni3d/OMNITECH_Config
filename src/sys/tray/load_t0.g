G91
var CurrentTrayAxisPosition = move.axes[3].machinePosition
if global.tray_0_state == 0
	echo "#messages.tray.loading#"^0^"#"
	G91
	set global.tray_0_state = -1
	G1 U1300 F3000
	G4 S2
	if sensors.filamentMonitors[4].status == "ok"
		echo "#messages.tray.loadingDone#"^0^"#"
		set global.tray_0_state = 1
		G90
	else
		set global.tray_0_state == 0
M591 D4 S1
if sensors.filamentMonitors[4].status == "ok"
	set global.tray_0_state = 1
else
	set global.tray_0_state = 0
G90
G92 U{var.CurrentTrayAxisPosition}