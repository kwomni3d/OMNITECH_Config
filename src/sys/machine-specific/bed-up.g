;bed-down.g
;moves bed 10mm down during first procedure performed
;movement is done even Z axis not homed
;do it only if not triggered yet
if move.axes[2].homed && move.axes[2].machinePosition >=10
	G91					; relative positioning
	G1 Z{-10-tools[1].offsets[2]}  F2000 
	set global.bed_down_for_procedure = true
	G90					; absolute positioning