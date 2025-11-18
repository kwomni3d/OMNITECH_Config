;homey.g
; M98 P"/sys/machine-specific/bed-down.g"
T0 P0
M98 P"/sys/tpre0.g"
G91					; relative positioning

G1 Z10 F2000 H2    	; move bed down

G1 Y-600 F2500 H1 	; quick home Y
G1 Y4 F5000       	; go back
G1 Y-600 F500 H1  	; slow home Y
G0 F2500
M569 P40.0 S1 D3
M569 P41.0 S1 D3

G1 Z-10 F2000 H2    	; move bed up

G90               	; absolute positioning


M98 P"/sys/machine-specific/go-to-cleaning-location.g"