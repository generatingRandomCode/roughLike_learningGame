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

func _ready():
	print("_ready()");
	self.ship_current_health = ship_health
	self.ship_current_armor = ship_armor
	self.ship_current_shield = ship_shield
	#	not intit at this point
	#$ShipUI.setStats(self.ship_name,self.ship_current_health, self.ship_health, self.ship_current_armor, self.ship_armor,self.ship_current_shield, self.ship_shield)
	#$ShipUI/Action.hide()

#	send signal when the ship is clicked
func _on_area_3d_input_event(camera, event, position, normal, shape_idx):
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT and event.pressed == true:
				print("ship clicked: ", get_children())
				# name is the node name that is the same for every one 
				shipClicked.emit(self.get_instance_id())


func build():
	
	#	check for name or instanceID of button with ship name
	#if typeof(ship) == TYPE_INT:
	#	ship = instance_from_id(ship)
	#	ship = ship.name
	#var shipPath = "res://Ships/" + ship + ".tscn"
	#	why does load work but not preload?
	#print("ship: ", shipPath)
	#	get ship
	#ship = load(shipPath)
	#ship = ship.instantiate()
	#ship.name = "Model"
	#add_child(ship)
	# add ui to ship
	var shipUIInstance = shipUI.instantiate()
	self.add_child(shipUIInstance)
	print("shipChildren:")
	#self.ship_name = ship_name
	#self.ship_health = ship_health
	self.ship_current_health = ship_health
	#self.ship_armor = ship_armor
	self.ship_current_armor = ship_armor
	#self.ship_shield = ship_shield
	self.ship_current_shield = ship_shield
	$ShipUI.setStats(self.ship_name,self.ship_current_health, self.ship_health, self.ship_current_armor, self.ship_armor,self.ship_current_shield, self.ship_shield)
