;set global.tray_3_state = 0
;M591 D3 P0
;M950 J23 C"^11.io1.in"
;if sensors.gpIn[23].value == 1
;	M950 J23 C"nil"
;	M591 D3 P1 C"^11.io1.in" S1  
;	set global.tray_3_state = 1
;	M98 P"tray/probe_t3.g"
;else
;	M581 P23 T6 S1 R0 
;	set global.tray_3_state = 0
M591 D3 S1
if sensors.filamentMonitors[3].status == "ok"
	set global.tray_3_state = 1
	M98 P"tray/probe_t3.g"
else
	set global.tray_3_state = 0
	M591 D3 S0
