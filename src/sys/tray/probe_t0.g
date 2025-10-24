if global.tray_0_state == 0 | global.tray_0_state == 2

else
	set global.tray_0_state = 1
	G91
	T0 P0
	while iterations < 3
		G1 U8 F500
		if sensors.gpIn[8].value == 1
			set global.tray_0_state = 2
			break
		G1 U-8 F500
		if sensors.gpIn[8].value == 1
			set global.tray_0_state = 2
			break
	G90
