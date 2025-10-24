; pause.g
G91            		; relative positioning
G1 Z50 F3000		
G90            		; absolute positioning

M98 P"/sys/machine-specific/go-to-cleaning-location.g"

M42 P9 S0			; unlock all doors
M713 P10 S0
M713 P11 S0
