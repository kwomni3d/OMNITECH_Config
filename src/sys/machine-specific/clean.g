var sign = 0
if tools[0].state = "active"
	set var.sign = 1
elif tools[1].state = "active"
	set var.sign = -1
elif tools[2].state = "active"
	set var.sign = 1
elif tools[3].state = "active"
	set var.sign = -1

var x_movement = 10 * var.sign
G91
while iterations < 2
	G1 Y25  F5000
	G1 X{var.x_movement}	F5000
	G1 X{-1*var.x_movement}	F5000
	G1 Y25  F5000
	G1 Y-25  F5000
	G1 X{var.x_movement}	F5000
	G1 X{-1*var.x_movement}	F5000
	G1 Y-25  F4000
G90