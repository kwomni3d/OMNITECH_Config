; executed on print resume following a power loss

;fix Z offset when started up
M98 P"/sys/procedures/copy-offsets.g"
G92 Z{move.axes[2].machinePosition - tools[{state.currentTool}].offsets[2]}
G4 S1

G28 XY