; Select tool
var CurrTool = -1
if tools[0].state = "active"
	set var.CurrTool = 0
elif tools[1].state = "active"
	set var.CurrTool = 1
elif tools[2].state = "active"
	set var.CurrTool = 2
elif tools[3].state = "active"
	set var.CurrTool = 3

; Go to tool cleaning location
if move.axes[0].homed && move.axes[1].homed
	if   var.CurrTool == 0
		M98 P"/sys/machine-specific/go-to-clean-t0.g"
	elif var.CurrTool == 1
		M98 P"/sys/machine-specific/go-to-clean-t1.g"
	elif var.CurrTool == 2
		M98 P"/sys/machine-specific/go-to-clean-t0.g"
	elif var.CurrTool == 3
		M98 P"/sys/machine-specific/go-to-clean-t1.g"