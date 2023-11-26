extends BaseWepon

class_name BigLaserBeam

func loadedAction(action) -> void:
	# = self.getTargetGroup()
	action.setTargetsFromFieldOBJ(self.getTargetGroup(TargetPreselectionPatterns.FirstInRow)[0])
	$LaserBeam.fire($LaserBeam.global_position ,action.targetField.global_position)
	if action.targetField.has_node("Model"):
		executeDamageAction(action.targets)
