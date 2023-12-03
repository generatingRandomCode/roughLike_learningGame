extends TextureRect

@export var audio: AudioStreamPlayer;
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_half_pressed():
	Engine.time_scale = 0.5
	audio.play()


func _on_normal_pressed():
	Engine.time_scale = 1
	audio.play()


func _on_double_pressed():
	Engine.time_scale = 2
	audio.play()
