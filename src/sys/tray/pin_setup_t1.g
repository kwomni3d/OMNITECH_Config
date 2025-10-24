;set global.tray_1_state = 0
;M591 D2 P0
;M950 J22 C"^11.io2.in"
;if sensors.gpIn[22].value == 1
;	M950 J22 C"nil"
;	M591 D2 P1 C"^11.io2.in" S1  
;	set global.tray_1_state = 1
;	M98 P"tray/probe_t1.g"
;else
;	M581 P22 T4 S1 R0 
;	set global.tray_1_state = 0
M591 D2 S1
if sensors.filamentMonitors[2].status == "ok"
	set global.tray_1_state = 1
	M98 P"tray/probe_t1.g"
else
	set global.tray_1_state = 0
	M591 D2 S0
