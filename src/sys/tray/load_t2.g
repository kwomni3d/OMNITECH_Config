G91
var CurrentTrayAxisPosition = move.axes[4].machinePosition
if global.tray_2_state == 0
	echo "#messages.tray.loading#"^2^"#"
	G91
	set global.tray_2_state = -1
	G1 V1300 F3000
	G4 S2
	if sensors.filamentMonitors[5].status == "ok"
		echo "#messages.tray.loadingDone#"^2^"#"
		set global.tray_2_state = 1
		G90
	else
		set global.tray_2_state == 0
M591 D5 S1
if sensors.filamentMonitors[5].status == "ok"
	set global.tray_2_state = 1
else
	set global.tray_2_state = 0
G90
G92 V{var.CurrentTrayAxisPosition}