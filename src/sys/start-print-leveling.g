; Reconfigure probe to have higher dive height in order to avoid hitting the bed when its misaligned heavily
M558 K0 C"20.io2.in" P8 H10:5 F500:250 T8000 A5 S0.03 B0
; Clear any bed transform
M561                   
; Remove current mesh
M30 "/sys/heightmap.csv" 
; Level
M98 P"/sys/machine-specific/probe-platform-points.g"
; Second Level
;M98 P"/sys/machine-specific/probe-platform-points.g"
; Reconfigure probe to default value
M98 P"/sys/machine-specific/set-probe-default-config-t0.g"
;Fast Probe for Z after leveling
G91 				;relative postitioning
G1 Z10 F1500 H1		;go down 10mm but not further than
G90
G31 Z0
M98 P"/sys/machine-specific/go-to-platform-center.g"
M98 P"/sys/t0-zoffset.g" 
G30 Z-800					; probe
G1 Z10 F2500

