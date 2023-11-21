extends Node3D
#spawn ship on click
var isEmpty = true


signal playerPlaced

func _ready():
	$Ship.show()

func _on_area_3d_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton:
		if(isEmpty):
			if event.button_index == MOUSE_BUTTON_LEFT and event.pressed == true:
				isEmpty = false;
				print("init_",name)
				playerPlaced.emit(self.get_instance_id())
				#	clear the local clickable field
				$Area3D.queue_free()
				$Ship.queue_free()


