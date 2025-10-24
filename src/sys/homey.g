;homey.g
; M98 P"/sys/machine-specific/bed-down.g"
T0 P0
M98 P"/sys/tpre0.g"
G91					; relative positioning

G1 Y-600 F2500 H1 	; quick home Y
G1 Y4 F5000       	; go back
G1 Y-600 F500 H1  	; slow home Y
G0 F2500
M569 P40.0 S1 D3
M569 P41.0 S1 D3
G90               	; absolute positioning

; if !global.y_closed_loop_calibrated
G91
G1 Y10 F3000
	; Configure Y0 closed loop control
	;M569.1 P40.0 T2 C1000 H20 E2:4 A20000 V1000							; Configure the 1HCL board at CAN address 50 with a quadrature encoder on the motor shaft that has 5 steps per motor full step (1000/200)
M569.1 P40.0 T2 C1000 H20 E2:4 A100000.0 V100.0 R100.0 I4000.000 D0.300						; Configure the 1HCL board at CAN address 50 with a quadrature encoder on the motor shaft that has 5 steps per motor full step (1000/200)
M569 P40.0 S1 D4					; Configure the motor on the 1HCL at can address 50 as being in closed-loop drive mode (D4) and not reversed (S1)
M569.6 P40.0 V1		; Perform the tuning manoeuvres for a quadrature encoder
M569 P40.0 S1 D3
	; Configure Y1 closed loop control
	;M569.1 P41.0 T2 C1000 H20 E2:4 A20000 V1000								; Configure the 1HCL board at CAN address 50 with a quadrature encoder on the motor shaft that has 5 steps per motor full step (1000/200)
M569.1 P41.0 T2 C1000 H20 E2:4 A100000.0 V100.0 R100.0 I4000.000 D0.300						; Configure the 1HCL board at CAN address 50 with a quadrature encoder on the motor shaft that has 5 steps per motor full step (1000/200)
M569 P41.0 S1 D4								; Configure the motor on the 1HCL at can address 50 as being in closed-loop drive mode (D4) and not reversed (S1)
M569.6 P41.0 V1										; Perform the tuning manoeuvres for a quadrature encoder
M569 P41.0 S1 D3
G0 Y-10 F3000
G90
set global.y_closed_loop_calibrated = true

M98 P"/sys/machine-specific/go-to-cleaning-location.g"