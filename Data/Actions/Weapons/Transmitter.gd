extends BaseWepon

class_name Transmitter

func _ready():
	needTarget = 1

func loadedAction(action) -> void:
	if action.targetField.has_node("Model"):
		executeDamageAction(action.targets)
