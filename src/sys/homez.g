;preheating

M98 P"/sys/procedures/prepare-for-calibration.g" S0

G91 				;relative postitioning
G1 Z10 F1500 H1		;go down 10mm but not further than
G90

G31 Z0
;M568 P0 S210 R210 A2		;set probing remperature
;M106 P0 S1					;fan on
	
;M106 P0 S0
;set probe default points
;M98 P"/sys/machine-specific/set-probe-default-config-t0.g"
M98 P"/sys/machine-specific/go-to-platform-center.g"
M98 P"/sys/t0-zoffset.g" 
G30 Z-800					; probe
G1 Z10 F2500

M98 P"/sys/machine-specific/go-to-cleaning-location.g"
