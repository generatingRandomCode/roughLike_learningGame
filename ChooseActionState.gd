extends State


# Called when the node enters the scene tree for the first time.
func _ready():
	$ActionUI.hide()
	pass # Replace with function body.

func enter(parameter := {}) -> void:
	print("choose Action State")
	#$ActionUI.show()
