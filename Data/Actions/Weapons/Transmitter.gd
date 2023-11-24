extends baseAction

class_name Transmitter

func loadedAction(action) -> void:
	if action.targets:
		action.targets.ship_current_energy = min(action.targets.ship_current_energy + 5 ,action.targets.ship_energy)
		
