if global.tray_1_state == 0 | global.tray_1_state == 2

else
	set global.tray_1_state = 1
	G91
	T1 P0
	while iterations < 3
		G1 W8 F500
		if sensors.gpIn[11].value == 1
			set global.tray_1_state = 2
			break
		G1 W-8 F500
		if sensors.gpIn[11].value == 1
			set global.tray_1_state = 2
			break
	G90
