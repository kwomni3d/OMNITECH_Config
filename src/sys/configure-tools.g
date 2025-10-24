;=== Define tool 0 ===
M563 P0 S"Left Extruder Spool 0" D0:2 H0 F0             ; define tool 0
M567 P0 E1.0:1.025										; set tool mix ratios
M568 P0 R0 S0 A0

;=== Define tool 1 ===
M563 P1 S"Right Extruder Spool 0" D1:4 H1 F1            ; define tool 1
M567 P1 E1.0:1.025										; set tool mix ratios
M568 P1 R0 S0 A0

;=== Define tool 2 ===
M563 P2 S"Left Extruder Spool 1" D0:3 H0 F0             ; define tool 2
M567 P2 E1.0:1.025										; set tool mix ratios
M568 P2 R0 S0 A0

;=== Define tool 3 ===
M563 P3 S"Right Extruder Spool 1" D1:5 H1 F1            ; define tool 3
M567 P3 E1.0:1.025										; set tool mix ratios
M568 P3 R0 S0 A0

set global.drives_A_switched = false
set global.drives_B_switched = false

M98 P"/sys/startup-z-offset.g"
M98 P"/sys/startup-xy-offset.g"