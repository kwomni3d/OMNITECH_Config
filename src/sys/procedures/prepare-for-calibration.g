T{param.S} P0
var cleaningTemp = 200
if {param.S} == 0
	set var.cleaningTemp = global.a_extruder_temp
	M98 P"/sys/machine-specific/head0-down.g"
else
	set var.cleaningTemp = global.b_extruder_temp
M568 P{param.S} R{var.cleaningTemp} S{var.cleaningTemp} A2
M98 P"/sys/machine-specific/go-to-cleaning-location.g"
M116 P{param.S}
G1 E-10
M98 P"/sys/machine-specific/clean.g"
M568 P{param.S} R{global.procedure_temp} S{global.procedure_temp} A2
if heat.heaters[{param.S}].current > global.procedure_temp
	M106 P{param.S} S255
M116 P{param.S}
M106 P{param.S} S0
M98 P"/sys/machine-specific/clean.g"
