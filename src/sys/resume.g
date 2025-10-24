M42 P9 S1	;lock front door
M713 P10 S1
M713 P11 S1
;restore resume temps and remove it
M98 P"/sys/resume-temps.g"
echo > "/sys/resume-temps.g" ""