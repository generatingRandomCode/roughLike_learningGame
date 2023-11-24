extends BaseWepon

class_name BigLaserBeam

func loadedAction(action) -> void:
	$LaserBeam.fire(self.global_position ,action.targetField.global_position)
	if action.targetField.has_node("Model"):
		executeDamageAction(action.targets)
