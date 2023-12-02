extends Node3D

@export var audio: AudioStreamPlayer3D;
# Called when the node enters the scene tree for the first time.
func _ready():
	audio.play()



