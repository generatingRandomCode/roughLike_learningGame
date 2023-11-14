extends CharacterBody3D

#	This function is called when the collision box of the ship is clicked
#	see the ship struckture for refference how it is strucktured
func _on_area_3d_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed == true:
			#	debug message
			print("pressed left mouse button");
