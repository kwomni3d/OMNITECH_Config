T0 P0																;select tool but don't run servo
T-1
M568 P0 A2															;activate heater using set temperature
M568 P0 S{global.a_extruder_temp} R{global.a_extruder_temp} A2		;heat to 250 when cold-started
M568 P2 S{global.a_extruder_temp} R{global.a_extruder_temp} A2		;heat to 250 when cold-started