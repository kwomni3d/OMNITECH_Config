T0 P0
M98 P"/sys/tpre0.g"														; select left tool
;set probe default points
;M98 P"/sys/machine-specific/go-to-platform-center.g"
;M98 P"/sys/t0-zoffset.g" 	
;G30 Z-800					; probe
G1 Z10 F2500
G29 S0
G1 Z10
