extends BaseWepon

class_name BigLaserBeam

func loadedAction(action) -> void:
	if action.targetField.has_node("Model"):
		executeDamageAction(action.targets)
