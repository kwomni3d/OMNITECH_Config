;set global.tray_2_state = 0
;M591 D5 P0
;M950 J25 C"^10.io1.in"
;if sensors.gpIn[25].value == 1
;	M950 J25 C"nil"
;	M591 D5 P1 C"^10.io1.in" S1  
;	set global.tray_2_state = 1
;	M98 P"tray/probe_t2.g"
;else
;	M581 P25 T8 S1 R0 
;	set global.tray_2_state = 0
M591 D5 S1
if sensors.filamentMonitors[5].status == "ok"
	set global.tray_2_state = 1
	M98 P"tray/probe_t2.g"
else
	set global.tray_2_state = 0
	M591 D5 S0
