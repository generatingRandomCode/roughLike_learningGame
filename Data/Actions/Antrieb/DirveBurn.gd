extends BaseAntriebe

class_name DriveBurn

func loadedAction(action) -> void:
	print("field test: drive", action.action)
	move(action.cause,action.targetField)
	print("TargetPreselectionPatterns: ",TargetPreselectionPatterns.Enemy )
