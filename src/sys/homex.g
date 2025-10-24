; homex.g
; M98 P"/sys/machine-specific/bed-down.g"

T0 P0
M98 P"/sys/tpre0.g"

G91					; relative positioning
G1 X-600 F5000 H1 	; quick home X
G1 X4 F6000       	; go back
G1 X-600 H1 F600 	; slow home X
G90               	; absolute positioning	

G91
G1 X10 F3000
M569.1 P30.0 T2 C1000 H20 E2:4 A100000.0 V100.0 R100.0 I4000.000 D0.300						; Configure the 1HCL board at CAN address 50 with a quadrature encoder on the motor shaft that has 5 steps per motor full step (1000/200)
M569 P30.0 S0 D4
M569.6 P30.0 V1	
M569 P30.0 S0 D3
G1 X-10 F3000
G90