extends Node3D

#	base class of a ship template
class_name BaseShip


#	Basic Ship Variables
@export var ship_name : String
@export var ship_health : int
@export var ship_armor : int 
@export var ship_shield : int
var ship_current_health 
var ship_current_armor 
var ship_current_shield

#	the weapons of the ship, the sub nodes of the wepons 
@export var wepons : Array[Node]

#when the ship gets clicked
signal shipClicked

var shipUI = preload("res://ship_ui.tscn")

#	init loads ships with zero health
func _enter_tree():
	self.ship_current_health = self.ship_health
	self.ship_current_armor = self.ship_armor
	self.ship_current_shield = self.ship_shield
	#	add ui
	var shipUIInstance = shipUI.instantiate()
	self.add_child(shipUIInstance)
	#	init ki
	$ShipUI.setStats(self.ship_name,self.ship_current_health, self.ship_health, self.ship_current_armor, self.ship_armor,self.ship_current_shield, self.ship_shield)

#	send signal when the ship is clicked
func _on_area_3d_input_event(camera, event, position, normal, shape_idx):
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT and event.pressed == true:
				# name is the node name that is the same for every one 
				shipClicked.emit(self.get_instance_id())

