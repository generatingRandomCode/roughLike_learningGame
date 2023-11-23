extends Node3D

#	base class of a ship template
class_name BaseShip

var explosion = preload("res://Data/3DVisual/Explosion_Particle.tscn")
#	Basic Ship Variables
@export var ship_name : String
@export var ship_health : int
@export var ship_armor : int 
@export var ship_shield : int
var ship_current_health 
var ship_current_armor 
var ship_current_shield

#	the weapons of the ship, the sub nodes of the wepons 
@export var actions : Array[Node]
@export var bonusActions : Array[Node]

#when the ship gets clicked
signal shipClicked

var shipUI = preload("res://ship_ui.tscn")

#	init loads ships with zero health
func _enter_tree():
	add_to_group("ship")
	self.ship_current_health = self.ship_health
	self.ship_current_armor = self.ship_armor
	self.ship_current_shield = self.ship_shield
	#	add ui
	var shipUIInstance = shipUI.instantiate()
	self.add_child(shipUIInstance)
	#	init ki
	$ShipUI.setStats(self.ship_name,self.ship_current_health, self.ship_health, self.ship_current_armor, self.ship_armor,self.ship_current_shield, self.ship_shield)
func _ready():
	get_node("AnimationPlayer").play("Ship_Idle_Animation")
#	send signal when the ship is clicked
func _on_area_3d_input_event(camera, event, position, normal, shape_idx):
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT and event.pressed == true:
				# name is the node name that is the same for every one 
				shipClicked.emit(self.get_instance_id())

#	why cant i quee free the player
func checkHealthIsAboveZero():
	if self.ship_current_health > 0:
		return true
	return false


func destroySelf():
	var explosionInstance = explosion.instantiate()
	#await get_tree().create_timer(.1).timeout
	#hide()
	for x in get_children():
		remove_child(x)
		x.queue_free()

	add_child(explosionInstance)
	await get_tree().create_timer(.5).timeout
	if get_parent():
		get_parent().remove_child(self)
	queue_free()

