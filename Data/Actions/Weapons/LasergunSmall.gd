extends BaseWepon



class_name LaserGunSmall

func _ready():
	needTarget = 1

func loadedAction(action) -> void:
	self.rotation_degrees = Vector3(0,self.global_position.angle_to(action.targets.global_position),0)
	self.get_node("LaserBeam").fire(action, self.timeNeededForAction)
	for x in $Model.get_children():
		x.fire()
		await get_tree().create_timer(0.01).timeout

