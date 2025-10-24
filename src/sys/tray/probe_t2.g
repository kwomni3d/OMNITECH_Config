if global.tray_2_state == 0 | global.tray_2_state == 2
	
else
	set global.tray_2_state = 1
	G91
	T2 P0
	while iterations < 3
		G1 V8 F500
		if sensors.gpIn[8].value == 1
			set global.tray_2_state = 2
			break
		G1 V-8 F500
		if sensors.gpIn[8].value == 1
			set global.tray_2_state = 2
			break
	G90
