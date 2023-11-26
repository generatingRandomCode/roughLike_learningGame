extends BaseAntriebe

class_name DriveBurn
var target
var distanceX
var distanceY
var distanceZ
var startTransform
var t = 0.0

func _ready():
	set_process(false)

func loadedAction(action) -> void:
	
	target = action.targetField.global_transform
	startTransform = get_parent_node_3d().global_transform
	#distance = get_parent_node_3d().global_position.distance_to(target)
	#distanceX = target.x - get_parent_node_3d().global_position.x
	#distanceY = target.y - get_parent_node_3d().global_position.y
	#distanceZ = target.z - get_parent_node_3d().global_position.z
	t = 0.0
	set_process(true)
	#var tween = get_tree().create_tween()
	#tween.set_parallel(true)
	#tween.tween_property(self, "global_position",target, 1)
	await get_tree().create_timer(1).timeout
	set_process(false)
	move(action.cause,action.targetField)
	

func _process(delta):
	#progress += delta
	t += delta
	#get_parent_node_3d().global_position = Vector3(get_parent_node_3d().global_position.x+distanceX*delta,get_parent_node_3d().global_position.y+distanceY, get_parent_node_3d().global_position.z+distanceZ)
	get_parent().global_transform = startTransform.interpolate_with(target, t)
