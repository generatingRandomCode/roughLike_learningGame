extends Node3D


#	This class hast all the basic functions to create a instance ship
class_name ShipTemplate

#	BASIC SHUP VALUES
@export var ship_name: String
@export var ship_health: int 
var ship_current_health 
var ship_armor 
var ship_current_armor 
var ship_shield 
var ship_current_shield
#var ship

#signal mouse_click
#	gets called when ship is init
# Called when the node enters the scene tree for the first time.


func build(ship):
	print("shipID: ", ship)
	if typeof(ship) == TYPE_INT:
		ship = instance_from_id(ship)
		ship = ship.name
	var shipPath = "res://Ships/" + ship + ".tscn"
	#	why does load work but not preload?
	print("ship: ", shipPath)
	ship = load(shipPath)
	ship = ship.instantiate()
	ship.name = "Model"
	add_child(ship)
	self.ship_name = $Model.ship_name
	self.ship_health = $Model.ship_health
	self.ship_current_health = $Model.ship_health
	self.ship_armor = $Model.ship_armor
	self.ship_current_armor = $Model.ship_armor
	self.ship_shield = $Model.ship_shield
	self.ship_current_shield = $Model.ship_shield
	$ShipUI.setStats(self.ship_name,self.ship_current_health, self.ship_health, self.ship_current_armor, self.ship_armor,self.ship_current_shield, self.ship_shield)


