extends Node3D
#spawn ship on click
var doesHover : bool = false


signal fieldSelect


func _ready():
	add_to_group("Field")
	$Ship.show()
	$FieldSelect.hide()

func _on_area_3d_input_event(camera, event, position, normal, shape_idx):
	
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed == true:
			if has_node("Ship"):
				$Ship.queue_free()
			fieldSelect.emit(self.get_instance_id())


func displayShipUI():
	if !has_node("Model"):
		return
	print("TestDisplay")
	if doesHover:
		$Model/ShipUI.show()
	else:
		$Model/ShipUI.hide()


func _on_area_3d_mouse_entered():
	doesHover = true
	displayShipUI()

func _on_area_3d_mouse_exited():
	doesHover = false
	displayShipUI()
