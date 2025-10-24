T1 P0	;select tool but don't run servo
T-1
M568 P1 A2								;activate heater using set temperature
;if heat.heaters[1].active < 200.0
M568 P1 S{global.b_extruder_temp} R{global.b_extruder_temp} A2
M568 P3 S{global.b_extruder_temp} R{global.b_extruder_temp} A2