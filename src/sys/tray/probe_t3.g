if global.tray_3_state == 0 | global.tray_3_state == 0

else
	set global.tray_3_state = 1
	G91
	T3 P0
	while iterations < 3
		G1 A8 F500
		if sensors.gpIn[11].value == 1
			set global.tray_3_state = 2
			break;
		G1 A-8 F500
		if sensors.gpIn[11].value == 1
			set global.tray_3_state = 2
			break;
	G90
