extends Node3D
#spawn ship on click
var isEmpty = true


signal shipClicked


func _ready():
	add_to_group("Field")
	$Ship.show()
	$FieldSelect.hide()

func _on_area_3d_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed == true:
			if has_node("Ship"):
				$Ship.queue_free()
			print("_on_area_3d_input_event PlayerGrid")
			shipClicked.emit(self.get_instance_id())


