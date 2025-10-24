;head0-down.g
;move left head down

M42 P8 S150	;set servo PWM
M42 P7 S1	;turn on servo supply voltage
M42 P8 S150	;set servo PWM again

G4 S1		;wait

M42 P7 S0	;turn off servo