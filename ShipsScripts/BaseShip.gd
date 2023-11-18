extends Node3D

class_name BaseShip

#	base class of a ship template
func _on_area_3d_input_event(camera, event, position, normal, shape_idx):
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT and event.pressed == true:
				print("ship clicked: ", get_children())

