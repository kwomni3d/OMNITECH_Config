; Initial setup
G4 S2                                                                     ; Needed for synchronization with toolboards
M929 P"log.txt" S1                                                        ; Enable logging
; =========== Axes ===========

; Drives
G90                                                                       ; Absolute coordinates
M82                                                                       ; Absolute extruder moves

M569 P0.3 S0 D3                                                           ; Drive X0
M569 P0.4 S1 D3                                                           ; Drive Y0
M569 P0.5 S1 D3                                                           ; Drive Y1
M569 P0.0 S0 D3                                                           ; Drive Z0
M569 P0.1 S0 D3                                                           ; Drive Z1
M569 P0.2 S0 D3                                                           ; Drive Z2
M569 P10.0 S0 D3                                                          ; Drive E0
M569 P10.1 S0 D3                                                          ; Drive E1

;Drive Assignment
M584 X0.3 Y0.4:0.5 Z0.0:0.1:0.2 E10.0:10.1 P3

;Microstepping
M350 X16 Y16 Z16 E16:16 I1

;Steps / mm
M92 X320 Y320 Z5120 E196.5:196.5
M203 X9000 Y9000 Y18000.00 Z2000.00 E10000.00                               ;9000 mm/min is a max limit derived from closed loop calibration				
M566 X500 Y500 Z150 E500 P1                                               ;(mm/min)												
M201 X5000 Y5000 Z90.00 E5000.00														
M204 P5000 T5000																			
M906 X5000 Y4000 Z3500 E1200:1200 I30			

; Z-Probe
M98 P"/sys/machine-specific/set-probe-default-config-t1.g"
M98 P"/sys/machine-specific/set-probe-default-config-t0.g"

; Z pivots
M557 X30:490 Y15:490 P10:10                                               ; Define Mesh Grid
M671 X0:255:510 Y0:510:0 S5	                                        	  ; Z pivots location

; Endstops
M574 X1 S1 P"0.io5.in"                                                   ; configure active-high endstop for low end on X0 via pin 30.io0.in
M574 Y1 S1 P"0.io6.in+0.io7.in"                                         ; configure active-high endstop for low end on Y0 via pin 50.io0.in and Y1 via pin 52.io0.in

; Axis Limits
M208 X-50 Y-2 Z0 S1                   ; set axis minima
M208 X500 Y500 Z575 S0                    ; set axis maxima

;Chamber Light
M950 P0 C"0.out7"                                                         ; chamber lights
M42 P0 S1                                                                 ; default on

; Signal tower
M950 P4 C"10.out6" Q1                                                     ; create gpOut on 1.out6 (green light), PWM frequency = 1 Hz
M950 P5 C"10.out5" Q1                                                     ; create gpOut on 1.out5 (yellow light), PWM frequency = 1 Hz
M950 P6 C"10.out4" Q1                                                     ; create gpOut on 1.out4 (red light), PWM frequency = 1 Hz

M715 P4:5:6                                                               ; Configure signal tower

;M950 P12 C"10.out2"                                                       ; configure print cooling fans and tower power supply
M42 P12 S0

; Left Nozzle
M308 S0 P"10.temp0" Y"pt1000" A"Left"                                     ; configure sensor 0 as thermistor on tool board board pin temp0
M950 H0 C"10.out0" T0                                                     ; create nozzle heater output on out0 and map it to sensor 0
M307 H0 R2.031 K0.172:0.194 D7.98 E1.35 S1.00 B0 V23.0
M143 H0 S480                                                              ; set temperature limit for heater 0 to 480C
M950 F0 C"10.out2" Q1000                                                  ; configure fan 0, F = 1 kHz,
M106 P0 S0

; Right Nozzle
M308 S1 P"10.temp1" Y"pt1000" A"Right"                                    ; configure sensor 0 as thermistor on tool board board pin temp0
M950 H1 C"10.out1" T1                                                     ; create nozzle heater output on out0 and map it to sensor 0
M307 H1 R2.031 K0.172:0.194 D7.98 E1.35 S1.00 B0 V23.0                    ; PID parameters - tuning together
M143 H1 S480                                                              ; set temperature limit for heater 1 to 480C											
M950 F1 C"10.out3" Q1000                                                  ; configure fan 1, F = 1 kHz,
M106 P1 S0

M42 P12 S1                                                                ; turn on print's fans power supply

; Bed Heaters
M308 S2 P"0.temp1" Y"pt1000" A"Bed Inner"                                 ; configure sensor 2 as thermistor on pin temp0
M308 S3 P"0.temp2" Y"pt1000" A"Bed Outer"                                 ; configure sensor 3 as thermistor on pin temp1
M950 H2 C"0.out1" T2 Q2                                                   ; create bed heater output on out1 and map it to sensor 2
M950 H3 C"0.out2" T3 Q2                                                   ; create bed heater output on out2 and map it to sensor 3
M307 H3 R0.405 K0.377:0.000 D3.87 E1.35 S1.00 B0
M307 H2 R0.505 K0.877:0.000 D6.24 E1.35 S1.00 B1	

M570 H2 P880 T120                                                         ; configure heater fault detection
M570 H3 P999999 T200                                                      ; configure heater fault detection
M143 H2 S180
M143 H3 S180
M140 P0 H2                                                                ; inner bed
M140 P1 H3                                                                ; outer bed

; Chamber
M308 S4 P"0.temp0" Y"pt1000" A"Chamber"                                  ; configure sensor 4 as pt1000 on pin 0.temp2
M950 H4 C"0.out3" T4 Q2                                                   ; create chamber heater output on 0.out9 and map it to sensor 4
M307 H4 R0.1 E1.35 K0.86 D10 S1 B1
M570 H4 P3600 T160                                                        ; configure heater fault detection to 600 seconds and 60C excursion
M143 H4 S170                                                              ; set temperature limit for heater 4 to 143C
M141 H4

M950 F2 C"0.out4"                                                         ; create chamber fan
M106 P2 S0
M711 H4 F2

;Servo
M950 P7 C"10.out8"
M950 S8 C"!10.io2.out" Q333
M42 P7 S0
M42 P8 S80

; ON / OFF button, MISC and auto save on power loss
M80 C"!0.out5"                                                            ; power switch output	
M950 J0 C"0.io1.in"                                                       ; power button input
M581 T3 P0 S1 R0                                                          ; power button trigger
M950 J1 C"0.io0.in"                                                       ; 230V detect input
;M581 T4 P4 S0 R0										; 230V detect trigger
M911 S22 R23 P"M913 X0 Y0 Z0 E0"

;bolts
M950 P10 C"0.out8"                                                       ;top
M950 P11 C"0.out9"                                                       ;front
M42 P10 S0
M42 P11 S0
M712 P10 S13                                                              ;automatic closing
M712 P11 S14

;coolant sensors
M950 J2 C"^0.io2.in"                                                      ; low level

M581 T5 P2 S0 R0                                                        ; extremely low level trigger

global drives_A_switched = false
global drives_B_switched = false
M98 P"/sys/configure-tools.g"
;reset offsets
G10 P0 X0 Y0 Z0
G10 P1 X0 Y0 Z0

;Power management
M710 T3000
M710 H2 S2 P770                                                           ;bed
M710 H3 S2 P800
M710 H4 S1 P2650                                                          ;chamber

;door sensors
M950 J12 C"^0.io3.in"                                                    ;front door
M950 J13 C"^0.io4.in"                                                    ;top door

;Check if offsets file exists, else create them with default values
M98 P"load-offset-files.g" S"t0-zoffset.g"
M98 P"load-offset-files.g" S"t1-zoffset.g"
M98 P"load-offset-files.g" S"startup-z-offset.g"
M98 P"load-offset-files.g" S"startup-xy-offset.g"
;Load tool offsets
;M98 P"t-offsets.g"
;M98 P"startup-z-offset.g"
;M98 P"startup-xy-offset.g"
;Load Z position and remove last saving
;M98 P"startup-z-pos.g"
;echo > "/sys/startup-z-pos.g" ""
;Initialize global variables
global bed_down_for_procedure = false
global x_closed_loop_calibrated = false
global y_closed_loop_calibrated = false

global machine_name = "Omni TECH"

; Filament data buffers START
global filament_0_data = " "
global filament_1_data = " "

global rfid_0_data = " "
global rfid_1_data = " "

global user_0_data = " "
global user_1_data = " "
; Filament data buffers END

global procedure_started = false
global procedure_current_step = 0
global procedure_total_steps = 0
global procedure_parameters = 0

global auto_swap_left = false
global auto_swap_right = false
global print_start_setup = 0

global multi_material_mode = true

global e1_position_known = false
global e0_position_known = false

; define variables to store extruder temperature based on currently loaded filament. Base is 200.
global a_extruder_temp = 200
global b_extruder_temp = 200
global procedure_temp = 170

; Pause on filament monitor error variable
global pause_on_monitor = 0
global cooldown_on = 0

global hvc = 0
global leveling = 0
global mesh = 0
global homeZ = 0

;load saved globals
M98 P"startup-global-variables.g"

;load overrides
M98 P"/sys/machine-specific/config-override.g"
; Eksperymentalnie zwiększam limity opóźnień SPI o 100% żeby zobaczyć czy to powoduje utratę komunikacji AW
M576 S100 F20 P16
;Enable accelerometer and input shaping
M955 P20.0 I24
;Configure pressure advance
M572 D0:1 S0.062
;show coolant warning message
M98 P"/sys/procedures/check-coolant.g"
; Configure Input Shaping
M593 P"ei3" F70 S0.1
; Select default tool after probing others
T0 P0
; Configure RFID
G4 S5
M1000 S2
M98 P"config-override.g"
;
