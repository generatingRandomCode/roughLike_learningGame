extends BaseWepon

class_name Transmitter

func _ready():
	needTarget = 1

func action(action) -> void:
	executeDamageAction(action.targets)
