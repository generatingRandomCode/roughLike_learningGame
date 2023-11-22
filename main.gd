extends Node3D



signal start_pressed

func _on_button_pressed():
	print("start pressed")
	start_pressed.emit()
