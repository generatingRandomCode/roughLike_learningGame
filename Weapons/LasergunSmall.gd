extends BaseWepon



class_name LaserGunSmall

func _ready():
	needTarget = 1

func action(action) -> void:
	executeDamageAction(action.targets)
	for x in $Model.get_children():
		x.fire()
		await get_tree().create_timer(0.01).timeout
