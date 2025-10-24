;trigger5.g
;triggered when coolant sensors falls down to extremely low level

M98 P"/sys/procedures/check-coolant.g"
if state.status == "processing"
	M25
