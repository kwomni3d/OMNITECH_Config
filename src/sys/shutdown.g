M292
M291 R"#messages.shutdown.title#" P"#messages.shutdown.confirm#" S3

;save Z position
if move.axes[2].homed
	echo > "/sys/startup-z-pos.g" "G92 Z"^{move.axes[2].machinePosition}

if heat.heaters[0].current > 100.0 || heat.heaters[1].current > 100.0
	M291 R"#messages.shutdown.title#" P"#messages.shutdown.cooldown#" S0 T600
	
	if heat.heaters[0].current > 100.0
		M568 P0 S90 R90 A2
	if heat.heaters[1].current > 100.0
		M568 P1 S90 R90 A2
	
	;wait for reaching temperature
	M116 P0 S100
	M116 P1 S100
		
M98 P"procedures/save-globals.g"

M291 R"#messages.shutdown.title#" P"#messages.shutdown.shutdown#" S0 T10
M292
G4 S2
M999 B-1 P"OFF"