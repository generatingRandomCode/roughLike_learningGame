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
	t = 0.0
	set_process(true)
	await get_tree().create_timer(1.0).timeout
	set_process(false)
	move(action.cause,action.targetField)


func _process(delta):
	t += delta
	get_parent().global_transform = startTransform.interpolate_with(target, t)
