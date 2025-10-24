; Initial setup
G4 S2                                                                     ; Needed for synchronization with toolboards
M929 P"log.txt" S1                                                        ; Enable logging
; =========== Axes ===========

; Drives
G90                                                                       ; Absolute coordinates
M82                                                                       ; Absolute extruder moves

M569 P10.0 S1 D3                                                          ; Filament feeder
M569 P10.1 S0 D3                                                          ; Filament feeder
M569 P11.0 S1 D3                                                          ; Filament feeder
M569 P11.1 S0 D3                                                          ; Filament feeder

M569 P30.0 S0 D3                                                          ; Drive X0
M569 P40.0 S1 D3                                                          ; Drive Y0
M569 P41.0 S1 D3                                                          ; Drive Y1
M569 P50.0 S0 D3                                                          ; Drive Z0
M569 P51.0 S0 D3                                                          ; Drive Z1
M569 P52.0 S0 D3                                                          ; Drive Z2
M569 P20.0 S0 D3                                                          ; Drive E0
M569 P21.0 S0 D3                                                          ; Drive E1

;Drive Assignment
M584 X30.0 Y40.0:41.0 Z50.0:51.0:52.0 E20.0:21.0:11.1:11.0:10.1:10.0 U11.1 V11.0 W10.1 A10.0

; Brakes
M569.7 P50.0 C"out1"                                                      ; configure brake Z0
M569.7 P51.0 C"out1"                                                      ; configure brake Z1
M569.7 P52.0 C"out1"                                                      ; configure brake Z2
M671
;Microstepping
M350 X16 Y16 U32 V32 W32 A32 Z128 E32:32:32:32:32:32 I1

;Steps / mm
M92 X320 Y320 U351 V351 W351 A351 Z5120 E196.5:196.5:351:351:351:351
M203 X9000 Y9000 U18000 V18000 W18000 A18000 Y18000.00 Z2000.00 E10000.00 ;9000 mm/min is a max limit derived from closed loop calibration				
M566 X500 Y500 Z150 E500 P1                                               ;(mm/min)												
M201 X5000 Y5000 Z90.00 E5000.00														
M204 P5000 T5000																			
M906 X5000 Y4000 U1200 A1200 W1200 V1200 Z3500 E1200:1200:500:500:500:500 I30			

; Z-Probe
M98 P"/sys/machine-specific/set-probe-default-config-t1.g"
M98 P"/sys/machine-specific/set-probe-default-config-t0.g"

; Z pivots
M557 X30:490 Y15:490 P10:10                                               ; Define Mesh Grid
M671 X0:255:510 Y0:510:0 S5	                                        	  ; Z pivots location

; Endstops
M574 X1 S1 P"30.io0.in"                                                   ; configure active-high endstop for low end on X0 via pin 30.io0.in
M574 Y1 S1 P"50.io0.in+52.io0.in"                                         ; configure active-high endstop for low end on Y0 via pin 50.io0.in and Y1 via pin 52.io0.in
M574 Z2 S1 P"50.io1.in+51.io0.in+0.io1.in"                                ; configure active-high endstops for high end on Z for each motor

; Axis Limits
M208 X-33 Y0 Z-7 W-100000 A-100000 U-100000 V-100000 S1                   ; set axis minima
M208 X510 Y510 Z515 W100000 A100000 U100000 V100000 S0                    ; set axis maxima

M208 X-33 Y0 Z-7 W-100000 A-100000 U-100000 V-100000 S1                   ; set axis minima
M208 X510 Y510 Z515 W100000 A100000 U100000 V100000 S0  

;Chamber Light
M950 P0 C"0.out3"                                                         ; chamber lights
M42 P0 S1                                                                 ; default on

;LED strip

M950 P1 C"11.out6"                                                        ; red
M950 P2 C"11.out7"                                                        ; green
M950 P3 C"11.out8"                                                        ; blue

M42 P1 S1
M42 P2 S0.4
M42 P3 S0

; Signal tower
M950 P4 C"10.out6" Q1                                                     ; create gpOut on 1.out6 (green light), PWM frequency = 1 Hz
M950 P5 C"10.out4" Q1                                                     ; create gpOut on 1.out4 (yellow light), PWM frequency = 1 Hz
M950 P6 C"10.out3" Q1                                                     ; create gpOut on 1.out1 (red light), PWM frequency = 1 Hz

M715 P4:5:6                                                               ; Configure signal tower

M950 P12 C"10.out2"                                                       ; configure print cooling fans and tower power supply
M42 P12 S0

; Left Nozzle
M308 S0 P"20.temp1" Y"pt1000" A"Left"                                     ; configure sensor 0 as thermistor on tool board board pin temp0
M950 H0 C"20.out0" T0                                                     ; create nozzle heater output on out0 and map it to sensor 0
M307 H0 R2.031 K0.172:0.194 D7.98 E1.35 S1.00 B0 V23.0
M143 H0 S480                                                              ; set temperature limit for heater 0 to 480C
M950 F0 C"10.out7" Q1000                                                  ; configure fan 0, F = 1 kHz,
M106 P0 S0

; Right Nozzle
M308 S1 P"21.temp1" Y"pt1000" A"Right"                                    ; configure sensor 0 as thermistor on tool board board pin temp0
M950 H1 C"21.out0" T1                                                     ; create nozzle heater output on out0 and map it to sensor 0
M307 H1 R2.031 K0.172:0.194 D7.98 E1.35 S1.00 B0 V23.0                    ; PID parameters - tuning together
M143 H1 S480                                                              ; set temperature limit for heater 1 to 480C											
M950 F1 C"10.out8" Q1000                                                  ; configure fan 1, F = 1 kHz,
M106 P1 S0

M42 P12 S1                                                                ; turn on print's fans power supply

; Bed Heaters
M308 S2 P"0.temp0" Y"pt1000" A"Bed Inner"                                 ; configure sensor 2 as thermistor on pin temp0
M308 S3 P"0.temp1" Y"pt1000" A"Bed Outer"                                 ; configure sensor 3 as thermistor on pin temp1
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
M308 S4 P"10.temp0" Y"pt1000" A"Chamber"                                  ; configure sensor 4 as pt1000 on pin 0.temp2
M950 H4 C"0.out8" T4 Q2                                                   ; create chamber heater output on 0.out9 and map it to sensor 4
M307 H4 R0.1 E1.35 K0.86 D10 S1 B1
M570 H4 P3600 T160                                                        ; configure heater fault detection to 600 seconds and 60C excursion
M143 H4 S170                                                              ; set temperature limit for heater 4 to 143C
M141 H4

M950 F2 C"0.out4"                                                         ; create chamber fan
M106 P2 S0
M711 H4 F2

;Additional chamber sensor
M308 S7 P"10.temp2" Y"pt1000" A"Chamber Lower sensor"

; Filament chamber temperature sensors
M308 S5 P"0.temp2" Y"pt1000" A"Filament chamber 0"
M308 S6 P"0.temp3" Y"pt1000" A"Filament chamber 1"

; Filament chamber 0 (right)
M950 H5 C"0.out5" T5 Q1
M307 H5 A40 C700 D10 B1 S0.95
M570 H5 P3600 T60                                                         ; Heater fault detecion
M143 H5 S90 A2
M141 P1 H5

M950 F3 C"11.out3"                                                        ; create chamber fan
M106 P3 S0
M711 H5 F3


; Filament chamber 1 (middle)
M950 H6 C"0.out6" T6 Q1
M307 H6 A40 C700 D10 B1 S0.95
M570 H6 P3600 T60                                                         ; Heater fault detecion
M143 H6 S90 A2
M141 P2 H6

M950 F4 C"11.out4"                                                        ; create chamber fan
M106 P4 S0
M711 H6 F4

; 120 mm fans
M950 F5 C"10.out0" Q250								
M950 F6 C"10.out1" Q250								
M106 P5 L0 X0.25 H0:1 T100                                        ; right fan thermostatic control from extruders
M106 P6 L0 X1.00 H4   T60                                             ; left fan thermostatic control from chamber

;Servo
M950 P7 C"20.io0.out"
M950 S8 C"!20.out2" Q333
M42 P7 S0
M42 P8 S80

; ON / OFF button, MISC and auto save on power loss
M80 C"!0.out7"                                                            ; power switch output	
M950 J0 C"0.io5.in"                                                       ; power button input
M581 T3 P0 S1 R0                                                          ; power button trigger
M950 J1 C"0.io4.in"                                                       ; 230V detect input
;M581 T4 P4 S0 R0										; 230V detect trigger
M911 S22 R23 P"M913 X0 Y0 Z0 E0"

;front door electromagnet
M950 P9 C"52.out0"
M42 P9 S0

;bolts
M950 P10 C"41.out0"                                                       ;top front
M950 P11 C"41.out1"                                                       ;top back
M42 P10 S0
M42 P10 S0
M712 P10 S13                                                              ;automatic closing
M712 P11 S14


;hood lights
M950 P13 C"11.out0"
M42 P13 S1                                                                ; default off
M581 P13 T9 S1                                                            ; Trigger9 to switch lights on when front hood is opened
M581 P13 T10 S0                                                           ; Trigger10 to switch lights off when front hood is closed
;M716 P13 S10:11			;auto on/off

;coolant sensors
M950 J2 C"^0.io2.in"                                                      ; pump A low level
M950 J3 C"^0.io3.in"                                                      ; pump A extremely low level
M950 J4 C"^0.io6.in"                                                      ; pump B low level
M950 J5 C"^0.io7.in"                                                      ; pump B extremely low level

M581 T5 P3:5 S0 R0                                                        ; extremely low level trigger

global drives_A_switched = false
global drives_B_switched = false
M98 P"/sys/configure-tools.g"
;reset offsets
G10 P0 X0 Y0 Z0
G10 P1 X0 Y0 Z0
G10 P2 X0 Y0 Z0
G10 P3 X0 Y0 Z0

;Power management
M710 T3000
M710 H2 S2 P770                                                           ;bed
M710 H3 S2 P800
M710 H4 S1 P2650                                                          ;chamber
M710 H5 S3 P320                                                           ;filament chambers
M710 H6 S3 P320

;A																		  ; Configure filament sensig for tray A
M950 J7  C"^10.io0.in"                                                    ; A Tray - Upper left sensor	
M950 J6 C"^10.io3.in"                                                     ; A Tray - Upper right sensor
M950 J8 C"^!20.io0.in"                                                    ; Extruder 0 sensor
M591 D0 P3 C"20.io1.in" S1 A0 L31.78 E10 R20:180                          ; Extruder 0 filament monitor
M591 D4 P1 C"^10.io2.in" S1                                               ; simple sensor (high signal when filament present) A1 Tray - Lower left sensor 
M591 D5 P1 C"^10.io1.in" S1                                               ; simple sensor (high signal when filament present) A2 Tray - Lower right sensor

;B																		  ; Configure filament sensig for tray B
M950 J9 C"^11.io0.in"                                                     ; B Tray - Upper left sensor
M950 J10 C"^11.io3.in"                                                    ; B Tray - Upper right sensor
M950 J11 C"^!21.io0.in"                                                   ; Extruder 1 sensor
M591 D1 P3 C"21.io1.in" S1 A0 L25.68 E10 R20:180                          ; Extruder 1 filament monitor
M591 D2 P1 C"^11.io2.in" S1                                               ; simple sensor (high signal when filament present) B1 Tray - Lower left sensor 
M591 D3 P1 C"^11.io1.in" S1                                               ; simple sensor (high signal when filament present) B2 Tray - Lower right sensor 

;door sensors
M950 J12 C"^52.io1.in"                                                    ;front door - works only when electromagnet active
M950 J13 C"^41.io0.in"                                                    ;top front
M950 J14 C"^41.io1.in"                                                    ;top back

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

global machine_name = "Omni PRO"

global tray_0_state = false
global tray_1_state = false
global tray_2_state = false
global tray_3_state = false
	
; Filament data buffers START
global filament_0_data = " "
global filament_1_data = " "
global filament_2_data = " "
global filament_3_data = " "

global rfid_0_data = " "
global rfid_1_data = " "
global rfid_2_data = " "
global rfid_3_data = " "

global user_0_data = " "
global user_1_data = " "
global user_2_data = " "
global user_3_data = " "
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
; Home tray axis
G92 U0 A0 W0 V0
; Eksperymentalnie zwiększam limity opóźnień SPI o 100% żeby zobaczyć czy to powoduje utratę komunikacji AW
M576 S100 F20 P16
;Enable accelerometer and input shaping
M955 P20.0 I24
;Configure pressure advance
M572 D0:1:2:3:4:5 S0.062
; Configure filament trays
M98 P"tray/pin_setup_t0.g"
M98 P"tray/pin_setup_t2.g"
M98 P"tray/pin_setup_t1.g"
M98 P"tray/pin_setup_t3.g"
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
