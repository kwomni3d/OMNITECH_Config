;=== Define tool 0 ===
M563 P0 S"Left Extruder" D0 H0 F0             ; define tool 0
M568 P0 R0 S0 A0

;=== Define tool 1 ===
M563 P1 S"Right Extruder" D1 H1 F1            ; define tool 1
M568 P1 R0 S0 A0

set global.drives_A_switched = false
set global.drives_B_switched = false

M98 P"/sys/startup-z-offset.g"
M98 P"/sys/startup-xy-offset.g"