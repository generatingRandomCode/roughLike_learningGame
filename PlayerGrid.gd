extends Node3D
#spawn ship on click
var isEmpty = true
var shipTemplate = preload("res://test_ship_01.tscn")

signal playerPlaced

func _on_area_3d_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton:
		if(isEmpty):
			if event.button_index == MOUSE_BUTTON_LEFT and event.pressed == true:
				isEmpty = false;
				print("init_",name)
				playerPlaced.emit(self.name)
				#	clear the local clickable field
				$Area3D.queue_free()


