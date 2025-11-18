;save actual temperatures
var t0_temperature = tools[0].active[0]

;preheat T0
M98 P"/sys/procedures/preheat-t0.g"

M98 P"homex.g"
M98 P"homey.g"
M98 P"homez.g"

M98 P"/sys/machine-specific/go-to-cleaning-location.g"

M568 P0 S{var.t0_temperature} R{var.t0_temperature} A2 ;restore temperature