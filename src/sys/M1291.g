set global.procedure_started = true
set global.procedure_current_step = {param.C}
if exists(param.T)
	set global.procedure_total_steps = {param.T}

if exists(param.D)
	set global.procedure_parameters = {param.D}
else
	set global.procedure_parameters = -1
