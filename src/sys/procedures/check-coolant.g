if sensors.gpIn[3].value == 0 || sensors.gpIn[5].value == 0
	M291 R"#messages.lowLevelOfCoolant.title#" P"#messages.lowLevelOfCoolant.levelExtremelyLow#" S1 T0

elif sensors.gpIn[2].value == 0 || sensors.gpIn[4].value == 0
	M291 R"#messages.lowLevelOfCoolant.title#" P"#messages.lowLevelOfCoolant.levelLow#" S1 T0