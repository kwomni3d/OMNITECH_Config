;M98 P"/sys/procedures/prepare-for-calibration.g" S0
;M98 P"/sys/procedures/prepare-for-calibration.g" S1

T0 P0
M98 P"/sys/tpre0.g"														; select left tool
M98 P"/sys/t0-zoffset.g" 									; load G31 z offset
M98 P"/sys/machine-specific/go-to-platform-center.g"

;G30 Z-99999													; single Z-probe
G30 K0

T1 P0
M98 P"/sys/tpre1.g"											; select right tool
G31 Z0														; set 0.0mm Z trigger offset
M98 P"/sys/t1-zoffset.g" 									; load G31 z offset
M98 P"/sys/machine-specific/go-to-platform-center.g"

G30 K1 S-2	    									; single Z-probe
G0 Z15

T0 P0
M98 P"/sys/tpre0.g"		
echo > "/sys/startup-z-offset.g" "G10 P1 Z"^{tools[1].offsets[2]}
M98 P"procedures/copy-offsets.g"