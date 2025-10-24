G91
var CurrentTrayAxisPosition = move.axes[6].machinePosition
if global.tray_3_state == 0
	echo "#messages.tray.loading#"^3^"#"
	G91
	set global.tray_3_state = -1
	G1 A1000 F3000
	G4 S2
	if sensors.filamentMonitors[3].status == "ok"
		echo "#messages.tray.loadingDone#"^3^"#"
		set global.tray_3_state = 1
		G90
	else
		set global.tray_3_state = 0
M591 D3 S1
if sensors.filamentMonitors[3].status == "ok"
	set global.tray_3_state = 1
else
	set global.tray_3_state = 0
G90
G92 A{var.CurrentTrayAxisPosition}