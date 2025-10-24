;head0-up.g
;lift left head up

M42 P8 S80	;set servo PWM
M42 P7 S1	;turn on servo supply voltage
M42 P8 S80	;set servo PWM again

G4 S1		;wait

M42 P7 S0	;turn off servo