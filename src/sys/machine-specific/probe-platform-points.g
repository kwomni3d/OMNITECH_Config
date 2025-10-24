T0 P0
M98 P"/sys/machine-specific/head0-down.g"
;G30 P0 X10 Y5 Z-99999	F5000
;G30 P1 X10 Y490 Z-99999 F5000
;G30 P2 X510 Y490 Z-99999 F5000 S3
;G30 P3 X510 Y5 Z-99999 S3 F5000
;G28 ; home
while true
    G30 P0 X10  Y10  Z-99999 ; probe near a leadscrew
    G30 P1 X255 Y500 Z-99999 ; probe near a leadscrew
    G30 P2 X500 Y10  Z-99999 S3 ; probe near a leadscrew and calibrate 3 motors
    if abs(move.calibration.initial.deviation) < 0.01 || iterations > 3
        break