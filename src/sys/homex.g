; homex.g
; M98 P"/sys/machine-specific/bed-down.g"

T0 P0
M98 P"/sys/tpre0.g"

G1 Z10 F2000 H2    	; move bed down

G91					; relative positioning
G1 X-600 F5000 H1 	; quick home X
G1 X4 F6000       	; go back
G1 X-600 H1 F600 	; slow home X

G1 Z-10 F2000 H2    	; move bed up

G90               	; absolute positioning	