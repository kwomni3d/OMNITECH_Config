; run before tool is activated

M208 T0							; Adjust workplace

M42 P7 S0						; Enable servo converter

G91				       	 		; Relative mode
G1 Z5 F2000 H2		         			; move bed down
G90							; absolute mode

M280 P8 S96.2						; Make move
G4 P1000						; Wait...

M42 P7 S1						; Disable servo converter