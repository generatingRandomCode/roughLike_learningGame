extends Button

#	simple button to include

signal start_pressed

func _on_button_pressed():
	start_pressed.emit(self.name)

