var show_msg = false

if heat.heaters[0].state != "off" && heat.heaters[0].active > 120
	M568 P0 S100 R100 A2
	M568 P2 S100 R100 A2
	set var.show_msg = true

if heat.heaters[1].state != "off" && heat.heaters[1].active > 120
	M568 P1 S100 R100 A2
	M568 P3 S100 R100 A2
	set var.show_msg = true

if var.show_msg
	M291 R"#messages.extruderStandbyMode.title#" P"#messages.extruderStandbyMode.standbyEnabled#" S1