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