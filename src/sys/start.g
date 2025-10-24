M98 P"/sys/startup-z-offset.g"
M98 P"/sys/startup-xy-offset.g"
M98 P"/sys/procedures/copy-offsets.g"

if sensors.gpIn[6].value == 0 || sensors.gpIn[8].value == 0
	M98 P"/sys/procedures/check-coolant.g"
	;M0

M98 P"procedures/door-lock.g"

if !move.axes[0].homed					; conditional X homing
	G28 X
if !move.axes[1].homed					; conditional Y homing
	G28 Y
if !move.axes[2].homed					; conditional Y homing
	G28 Z

M106 P4 S1
M290 R0 S0								; reset babystepping
M220 S100
M30 "0:/sys/resurrect.g"				; remove resurrect file
;remove resume state temps
echo > "/sys/resume-temps.g" ""
