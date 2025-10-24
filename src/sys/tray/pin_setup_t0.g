;set global.tray_0_state = 0
;M591 D4 P0
;M950 J24 C"^10.io2.in"
;if sensors.gpIn[24].value == 1
;	M950 J24 C"nil"
;	M591 D4 P1 C"^10.io2.in" S1  
;	set global.tray_0_state = 1
;	M98 P"tray/probe_t0.g"
;else
;	M581 P24 T7 S1 R0 
;	set global.tray_0_state = 0
M591 D4 S1
if sensors.filamentMonitors[4].status == "ok"
	set global.tray_0_state = 1
	M98 P"tray/probe_t0.g"
else
	set global.tray_0_state = 0
	M591 D4 S0

