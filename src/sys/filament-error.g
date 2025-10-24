var active_temperature = 0
var standby_temperature = 0
var pa_l = 0
var pa_r = 0
var traystate = 0
var timeout = 0;
if {param.D} == 0 	;czujnik filamentu lewej głowicy
	var string = "#messages.runout.lowFlow#"^{param.D}^"#"^{sensors.filamentMonitors[0].avgPercentage}^"#"^{sensors.filamentMonitors[0].configured.percentMin}^"#"^{sensors.filamentMonitors[0].configured.percentMax}^"#"
	echo "#messages.runout.lowFlow#"^{param.D}^"#"^{sensors.filamentMonitors[0].avgPercentage}^"#"^{sensors.filamentMonitors[0].configured.percentMin}^"#"^{sensors.filamentMonitors[0].configured.percentMax}^"#"
	if global.pause_on_monitor == 1
	  	M25
elif {param.D} == 1	;czujnik filamentu prawej głowicy
	  echo "#messages.runout.lowFlow#"^{param.D}^"#"^{sensors.filamentMonitors[1].avgPercentage}^"#"^{sensors.filamentMonitors[1].configured.percentMin}^"#"^{sensors.filamentMonitors[1].configured.percentMax}^"#"
	  if global.pause_on_monitor == 1
	  	M25
elif {param.D} == 4 ;tool 0 error, tray right
	if state.status == "processing"
        if global.auto_swap_right == true
			echo "Filament runout on sensor: "^{param.D}^""
            M25		;pause SD print

            echo "#messages.runout.temperaturesSaved#"^{var.active_temperature}^"#"^{var.standby_temperature}^"#"
            set var.active_temperature  = tools[0].active[0]   ; Save Active temperature
            set var.standby_temperature = tools[0].standby[0] ; Save Standby temperature
            
            set var.pa_l = move.extruders[0].pressureAdvance
            set var.pa_r = move.extruders[1].pressureAdvance

            echo "#messages.runout.temperaturesSaved#"^{var.active_temperature}^"#"^{var.standby_temperature}^"#"
            set var.traystate = {global.tray_2_state}
            ;echo "#messages.runout.traystateOutsideLoop#{var.traystate}#"
            if {var.traystate} == 1
                ; 0. reset to default
                echo "#messages.runout.resetToDefaults#"
                M98 P"/sys/configure-tools.g"
                echo "#messages.runout.resetDone#"
                M568 P0 R{var.standby_temperature} S{var.active_temperature} 
                M568 P2 R{var.standby_temperature} S{var.active_temperature}
                ; 1. Unload current filament
                M1101 P0 S5
                if global.tray_0_state != 0
                    M291 P"Filament is stuck in the feeding tube. Please remove it and prime the other filament" R"Failed to unload filament"
                else
                    M1101 P2 S1
                    ; 2. prime extruder.
                    echo "#messages.runout.priming#"
                    while {var.traystate} != 2
                        set var.timeout = var.timeout + 1
                        if {var.timeout} == 60
                            M291 P"#messages.runout.unableToRetract#" R"#messages.runout.retractError#" S2
                            M99
                        set var.traystate = {global.tray_2_state}
                        ;echo "#messages.runout.loop3#{var.traystate}#"
                        G4 S1
                    ;3.Switch drives
                    ;Apply new configuration with switched drives.
                    M563 P0 D0:3 H0 F0
                    M567 P0 E1.0:1.0
                    M568 P0 R{var.standby_temperature} S{var.active_temperature} A2
                    M568 P2 R{var.standby_temperature} S{var.active_temperature}
                    G92 E0 A0 U0 W0 V0
                    M572 D0 S{var.pa_l}
                    M572 D1 S{var.pa_r}
                    T0
                    M98 P"/sys/startup-xy-offset.g"
                    M98 P"/sys/startup-z-offset.g"
                    echo "#messages.runout.cleaning#"
                    M98 P"/sys/machine-specific/clean.g"
                    M24
            else
				M25
				M291 P"#messages.runout.outOfFimanetForSwapping#" R"#messages.runout.error#" S2
        else
			M25
			M291 P"#messages.runout.outOfFimanetForSwapping#" R"#messages.runout.error#" S2

elif {param.D} == 5 ;tool 2 error, tray right
    if state.status == "processing"
        if global.auto_swap_right == true
			echo "Filament runout on sensor: "^{param.D}^""
            M25			;pause SD print
            set var.active_temperature = tools[0].active[0]
            set var.standby_temperature = tools[0].standby[0]
            
            set var.pa_l = move.extruders[0].pressureAdvance
            set var.pa_r = move.extruders[1].pressureAdvance

            echo "#messages.runout.temperaturesSaved#"^{var.active_temperature}^"#"^{var.standby_temperature}^"#"
            set var.traystate = {global.tray_0_state}
            ;echo "#messages.runout.traystateOutsideLoop#{var.traystate}#"
            if {var.traystate} == 1
                ; 0. reset to default
                echo "#messages.runout.resetToDefaults#"
                M98 P"/sys/configure-tools.g"
                echo "#messages.runout.resetDone#"
                M568 P0 R{var.standby_temperature} S{var.active_temperature}
                M568 P2 R{var.standby_temperature} S{var.active_temperature}
                ; 1. Retract current filament and load new
                M1101 P2 S5
                if global.tray_2_state != 0
                    M291 P"Filament is stuck in the feeding tube. Please remove it and prime the other filament" R"Failed to unload filament"
                else
                    M1101 P0 S1
                    ; 2. prime extruder.
                    echo "#messages.runout.priming#"
                    while {var.traystate} != 2
                        set var.timeout = var.timeout + 1
                        if {var.timeout} == 60
                            M291 P"#messages.runout.unableToRetract#" R"#messages.runout.retractError#" S2
                            M99
                        set var.traystate = {global.tray_0_state}
                        ;echo "#messages.runout.loop3#{var.traystate}#"
                        G4 S1
                    ; 3.Switch drives
                    ;Apply new configuration with switched drives.
                    M563 P2 D0:2 H0 F0
                    M568 P0 R{var.standby_temperature} S{var.active_temperature}
                    M568 P2 R{var.standby_temperature} S{var.active_temperature}                
                    M567 P2 E1.0:1.0
                    G92 E0 A0 U0 W0 V0
                    M572 D0 S{var.pa_l}
                    M572 D1 S{var.pa_r}
                    T0
                    M98 P"/sys/startup-xy-offset.g"
                    M98 P"/sys/startup-z-offset.g"
                    echo "#messages.runout.cleaning#"
                    M98 P"/sys/machine-specific/clean.g"
                    M24
            else
				M25
				M291 P"#messages.runout.outOfFimanetForSwapping#" R"#messages.runout.error#" S2
        else
			M25
			M291 P"#messages.runout.outOfFimanetForSwapping#" R"#messages.runout.error#" S2

elif {param.D} == 2 ; tool 1 error, tray left
    if state.status == "processing"
        if global.auto_swap_right == true
			echo "Filament runout on sensor: "^{param.D}^""
            M25			;pause SD print
            set var.active_temperature =   tools[1].active[0]
            set var.standby_temperature =  tools[1].standby[0]
            set var.pa_l = move.extruders[0].pressureAdvance
            set var.pa_r = move.extruders[1].pressureAdvance
            echo "#messages.runout.temperaturesSaved#"^{var.active_temperature}^"#"^{var.standby_temperature}^"#"
            set var.traystate = {global.tray_3_state}
            ;echo "#messages.runout.traystateOutsideLoop#{var.traystate}#"
            if {var.traystate} == 1
                ; 0. reset to default
                echo "#messages.runout.resetToDefaults#"
                M98 P"/sys/configure-tools.g"
                echo "#messages.runout.resetDone#"
                M568 P1 R{var.standby_temperature} S{var.active_temperature} A2
                M568 P3 R{var.standby_temperature} S{var.active_temperature} A2
                ; 1. Retract current filament and load new
                M1101 P1 S5
                if global.tray_1_state != 0
                    M291 P"Filament is stuck in the feeding tube. Please remove it and prime the other filament" R"Failed to unload filament"
                else
                    ; 2. prime extruder.
                    echo "#messages.runout.priming#"
                    M1101 P3 S1
                    while {var.traystate} != 2
                        set var.timeout = var.timeout + 1
                        if {var.timeout} == 60
                            M291 P"#messages.runout.unableToRetract#" R"#messages.runout.retractError#" S2
                            M99
                        set var.traystate = {global.tray_3_state}
                        ;echo "#messages.runout.loop3#{var.traystate}#"
                        G4 S1 
                    M83
                    G1 E50
                    ; 3.Switch drives - zrobione u góry w IF ELSE
                    ;Apply new configuration with switched drives.
                    echo "#messages.runout.applyingNewSettings#"
                    M563 P1
                    M563 P1 D1:5 H1 F1
                    M568 P1 R{var.standby_temperature} S{var.active_temperature} A2
                    M568 P3 R{var.standby_temperature} S{var.active_temperature} A2
                    M567 P1 E1.0:1.0
                    G92 E0 A0 U0 W0 V0
                    M572 D0 S{var.pa_l}
                    M572 D1 S{var.pa_r}
                    T1
                    M98 P"/sys/startup-xy-offset.g"
                    M98 P"/sys/startup-z-offset.g"
                    echo "#messages.runout.newSettings#"
                    M563 P1
                    echo "#messages.runout.cleaning#"
                    M98 P"/sys/machine-specific/clean.g"
                    M24
            else
               	M25
				M291 P"#messages.runout.outOfFimanetForSwapping#" R"#messages.runout.error#" S2
        else
			M25
			M291 P"#messages.runout.outOfFimanetForSwapping#" R"#messages.runout.error#" S2
			
elif {param.D} == 3 ; tool 3 error, tray left
    if state.status == "processing"
        if global.auto_swap_right == true
			echo "Filament runout on sensor: "^{param.D}^""
            M25			;pause SD print
			
            ;echo "#messages.runout.temperaturesSaved#"^{var.active_temperature}^"#"^{var.standby_temperature}^"#"
            set var.active_temperature = tools[1].active[0]
            set var.standby_temperature = tools[1].standby[0]
			
            set var.pa_l = move.extruders[0].pressureAdvance
            set var.pa_r = move.extruders[1].pressureAdvance

            ;echo "#messages.runout.temperaturesSaved#"^{var.active_temperature}^"#"^{var.standby_temperature}^"#"

            set var.traystate = {global.tray_1_state}
                
            ;echo "#messages.runout.traystateOutsideLoop#{var.traystate}#"

            if {var.traystate} == 1
                ; 0. reset to default
                echo "#messages.runout.resetToDefaults#"
                M98 P"/sys/configure-tools.g"
                echo "#messages.runout.resetDone#"
                M568 P1 R{var.standby_temperature} S{var.active_temperature} A2
                M568 P3 R{var.standby_temperature} S{var.active_temperature} A2
                ; 1. Unload current filament
				M1101 P3 S5
                if global.tray_3_state != 0
                    M291 P"Filament is stuck in the feeding tube. Please remove it and prime the other filament" R"Failed to unload filament"
                else
                    ; 2. prime extruder.
                    M1101 P1 S1
                    echo "#messages.runout.priming#"
                    while {var.traystate} != 2
                        set var.timeout = var.timeout + 1
                        if {var.timeout} == 60
                            M291 P"#messages.runout.unableToRetract#" R"#messages.runout.retractError#" S2
                            M99
                        set var.traystate = {global.tray_1_state}
                        ;echo "#messages.runout.loop3#{var.traystate}#"
                        G4 S1
                    ; 3.Prime Extruder
                    M83
                    G1 E50
                    ;Apply new configuration with switched drives.
                    echo "#messages.runout.applyingNewSettings#"
                    M563 P3
                    M563 P3 D1:4 H1 F1
                    M568 P1 R{var.standby_temperature} S{var.active_temperature} A2
                    M568 P3 R{var.standby_temperature} S{var.active_temperature} A2
                    M567 P3 E1.0:1.0
                    G92 E0 A0 U0 W0 V0
                    M572 D0 S{var.pa_l}
                    M572 D1 S{var.pa_r}
                    T1
                    M98 P"/sys/startup-xy-offset.g"
                    M98 P"/sys/startup-z-offset.g"
                    echo "#messages.runout.cleaning#"
                    M98 P"/sys/machine-specific/clean.g"
                    M24
            else
				M25
                M291 P"#messages.runout.outOfFimanetForSwapping#" R"#messages.runout.error#" S2
        else
			M25
            M291 P"#messages.runout.outOfFimanetForSwapping#" R"#messages.runout.error#" S2
