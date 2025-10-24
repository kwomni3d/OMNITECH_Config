;if move.axes[2].homed != true
;    M98 P"/sys/homez.g"
;M98 P"/sys/start-print-leveling.g"
;M98 P"/sys/machine-specific/set-probe-default-config-t0.g"
;M98 P"/sys/machine-specific/go-to-platform-center.g"
;M116 P1 S10 				; wait to reach temperature
;M106 P1 S0					; fan off
;M98 P"/sys/t1-zoffset.g" 
;G1 Z10 F2500