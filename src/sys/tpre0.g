
;if move.axes[2].homed
;	G91					; relative positioning
;	G1 Z{10 + tools[1].offsets[2]} F2000 
;	set global.bed_down_for_procedure = true
;	G90					; absolute positioning
M98 P"/sys/machine-specific/bed-down.g"
M98 P"/sys/machine-specific/head0-down.g"

M208 S1 Z0				; set axis max travel