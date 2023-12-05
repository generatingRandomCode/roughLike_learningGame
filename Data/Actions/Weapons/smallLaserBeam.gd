extends BaseWepon

class_name SmallLaserBeam

func loadedAction(action) -> void:
	action.setTargetsFromFieldOBJ(self.getTargetGroup(TargetPreselectionPatterns.FirstInRow)[0])
	$SmallLaserBeam.fire(action, self.timeNeededForAction)
