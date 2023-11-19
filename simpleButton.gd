extends Button

#	simple button to include

signal start_pressed

func _on_button_pressed():
	print("button id: ", self.get_instance_id())
	start_pressed.emit(self.get_instance_id())

