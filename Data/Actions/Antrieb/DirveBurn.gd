extends BaseAntriebe

class_name DriveBurn

func _ready():
	needTarget = true

func action(action) -> void:
	move(action.cause,action.targets)
	print("TargetPreselectionPatterns: ",TargetPreselectionPatterns.Enemy )
	


