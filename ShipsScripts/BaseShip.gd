extends Node3D

#	base class of a ship template
class_name BaseShip

var explosion = preload("res://Data/3DVisual/Explosion_Particle.tscn")
var shipUI = preload("res://ship_ui.tscn")

#	Basic Ship Variables
@export var ship_name : String
@export var shipModell : MeshInstance3D
var shipDestroyed : bool = false
#	ship base stats
@export var ship_health : int
var ship_current_health = null
@export var ship_armor : int 
var ship_current_armor = null
@export var ship_shield : int
var ship_current_shield = null
#	the ships energy and energy region
@export var ship_energy : int
var ship_current_energy = null
@export var ship_energy_regeneration : int 

#	the weapons of the ship, the sub nodes of the wepons 
@export var actions : Array[Node]
@export var bonusActions : Array[Node]

#when the ship gets clicked
#signal shipClicked

#	init loads ships with zero health
func _enter_tree():
	add_to_group("Ship")
	if self.ship_current_energy == null:
		self.ship_current_energy = self.ship_energy
	if self.ship_current_health == null:
		self.ship_current_health = self.ship_health
	if self.ship_current_armor == null:
		self.ship_current_armor = self.ship_armor
	if self.ship_current_shield == null:
		self.ship_current_shield = self.ship_shield
	#	add ui
	var shipUIInstance = shipUI.instantiate()
	self.add_child(shipUIInstance) #	updates itself
	
func _ready():
	get_node("AnimationPlayer").play("Ship_Idle_Animation")
#	send signal when the ship is clicked

#	why cant i quee free the player
func checkHealthIsAboveZero():
	if self.ship_current_health > 0:
		return true
	return false

# gets signalled from the action State
func checkForHealth(actionLoopEnd : bool = false):
	if actionLoopEnd:
		if !checkHealthIsAboveZero():
			print("destroy")
			destroySelf()
	else:
		if !checkHealthIsAboveZero():
			hideAndShowDestruction()

func destroySelf():
	for x in get_children():
		remove_child(x)
		x.queue_free()
	if get_parent():
		get_parent().remove_child(self)
	queue_free()

func hideAndShowDestruction():
	#	play the explosion when ship is not destroyed yet
	if !shipDestroyed:
		var explosionInstance = explosion.instantiate()
		add_child(explosionInstance)
		await get_tree().create_timer(.01).timeout
		shipDestroyed = true
	#	hide all ship and wepon models
	$TrusterParticle.hide()
	shipModell.hide()
	for action in bonusActions + actions:
		if action.has_node("Model"):
			action.get_node("Model").hide()
	#hide()
	

func updateEnergy():
	print("updateEnergy")
	ship_current_energy = min(ship_energy, ship_current_energy + ship_energy_regeneration)

func useEnergy(energyCost : int)->bool:
	if energyCost <= ship_current_energy:
		ship_current_energy = ship_current_energy - energyCost
		return true
	else:
		return false
