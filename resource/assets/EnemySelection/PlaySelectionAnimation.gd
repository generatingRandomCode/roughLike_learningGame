extends MeshInstance3D


# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("AnimationPlayer").play("new_animation")
	
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotation_degrees += Vector3(0, 100, 0) * delta
	pass
