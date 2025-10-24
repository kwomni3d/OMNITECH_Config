; Disable printing fans
M106 P0 S0
M106 P1 S0
; Retract filament to avoid oozing
M83
G1 E-5
M82
; Clean nozzle
M98 P"/sys/machine-specific/go-to-cleaning-location.g"
M98 P"/sys/machine-specific/clean.g"
; Move bed down
G91
G1 Z200 F1500
G90
; Unlock all doors
M42 P9 S0
M713 P10 S0
M713 P11 S0
; Disable all heaters
M98 P"/sys/machine-specific/cooldown.g"
; Remove resurrect file
M30 "0:/sys/resurrect.g"
; Reset tools configuration
M98 P"/sys/configure-tools.g"
M292
; Disable closed loop
M569 P30.0 S0 D3
M569 P40.0 S1 D3
M569 P41.0 S1 D3
