extends BaseWepon

class_name BigLaserBeam

func loadedAction(action) -> void:
	action.setTargetsFromFieldOBJ(self.getTargetGroup(TargetPreselectionPatterns.FirstInRow)[0])
	$LaserBeam.fire(action, self.timeNeededForAction)
