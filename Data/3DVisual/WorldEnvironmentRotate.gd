extends WorldEnvironment


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	environment.sky_rotation.y += .0001
	#environment.sky_rotation.z += 0.0001
	#environment.sky_rotation.x += 0.0001
	
	if environment.sky_rotation.y >= 360:
		environment.sky_rotation.y = 0
	if environment.sky_rotation.z >= 360:
		environment.sky_rotation.y = 0
	if environment.sky_rotation.x >= 360:
		environment.sky_rotation.y = 0
