extends Node3D

class_name BaseShip



@export var ship_name : String
@export var ship_health : int
@export var ship_armor : int 
@export var ship_shield : int

var weapon = ["small_laser_turret"]

#when the ship gets clicked
signal shipClicked
#	base class of a ship template
func _on_area_3d_input_event(camera, event, position, normal, shape_idx):
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT and event.pressed == true:
				print("ship clicked: ", get_children())
				shipClicked.emit(self.name)

