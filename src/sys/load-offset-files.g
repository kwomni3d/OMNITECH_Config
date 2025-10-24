;Check if offsets file exists, else create them with default values
var filepath = {param.S}
echo var.filepath
if (fileexists("sys/"^var.filepath))
	echo "Applying zoffset"
	M98 P{param.S}
else
	if var.filepath == "t0-zoffset.g"
		echo "Creating K0 zoffset"
		echo >> var.filepath "G31 K0 Z-0.45 ; z-offset applied after z homing. Increase this value to bring nozzle closer to the bed on first layer. "
	elif var.filepath == "t1-zoffset.g"
		echo "Creating K1 zoffset"
		echo >> var.filepath "G31 K1 Z-0.45 ; z-offset applied after z homing. Increase this value to bring nozzle closer to the bed on first layer. "
	elif var.filepath == "startup-z-offset.g"
		echo "Creating startup-z-offset file"
		echo >> var.filepath "G10 P1 Z0"
	elif var.filepath == "t-offsets.g"
		echo "Creating tool offsets file"
		echo >> var.filepath "G10 P0 X0.000 Y0.000 Z0.000" 
		echo >> var.filepath "G10 P1 X33.795 Y-0.497 Z0"
	else
		echo "No such file"
