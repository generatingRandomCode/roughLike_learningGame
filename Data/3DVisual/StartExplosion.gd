extends GPUParticles3D

@export var audio: AudioStreamPlayer3D
# Called when the node enters the scene tree for the first time.
func _ready():
	emitting = true # Replace with function body.
	audio.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
