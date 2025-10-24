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

;Configure closed loop
M569.1 P50.0 T2 C1000 H20 E2:4 A100000.0 V100.0 R100.0 I4000.000 D0.300
M569.1 P51.0 T2 C1000 H20 E2:4 A100000.0 V100.0 R100.0 I4000.000 D0.300
M569.1 P52.0 T2 C1000 H20 E2:4 A100000.0 V100.0 R100.0 I4000.000 D0.300
; Enable closed loop
M569 P50.0 S0 D3
M569 P51.0 S0 D3
M569 P52.0 S0 D3
; Perform calibration move
;M569.6 P50.0 V1	
;M569.6 P51.0 V1
;M569.6 P52.0 V1

M98 P"/sys/machine-specific/go-to-cleaning-location.g"
