extends BaseAntriebe

class_name DriveBurn

func loadedAction(action) -> void:
	move(action.cause,action.targetField)
