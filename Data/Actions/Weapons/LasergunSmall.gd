extends BaseWepon



class_name LaserGunSmall

func _ready():
	needTarget = 1

func loadedAction(action) -> void:
	self.get_node("LaserBeam").fire(get_node("LaserBeam").global_position ,action.targets.global_position, 1.2)
	
	get
	for x in $Model.get_children():
		x.fire()
		await get_tree().create_timer(0.01).timeout
	if action.targetField.has_node("Model"):
		executeDamageAction(action.targets)
