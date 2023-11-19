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
var ship

#signal mouse_click
#	gets called when ship is init
# Called when the node enters the scene tree for the first time.
func _ready():
	print("_ready()");
	$ShipUI.setStats(self.ship_name,self.ship_current_health, self.ship_health, self.ship_current_armor, self.ship_armor,self.ship_current_shield, self.ship_shield)
	$ShipUI/Action.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

func damage_step(damage):
	var oldH = self.ship_current_health
	var oldA = self.ship_current_armor
	var oldS = self.ship_current_shield
	take_damage(damage)
	displayDamage(oldH,oldA,oldS)
	
	
func displayDamage(health, armor, shield):
	var string = "healt damage: {0}, armordamage: {1}, shielddamage: {2}"
	health = max(0,health - self.ship_current_health)
	armor = max(0, armor - self.ship_current_armor)
	shield = max(0, shield- self.ship_current_shield)
	string = string.format([health,armor,shield])
	$damageText/HBoxContainer/Label.text = string
		
func take_damage(damage):
	if ship_current_shield > 0:
		if damage > ship_current_shield:
			damage = damage - ship_current_shield
			ship_current_shield = 0
			take_damage(damage)
		else:
			ship_current_shield = ship_current_shield - damage
	elif ship_current_armor > 0:
		if damage > ship_current_armor * 2:
			damage = damage - ship_current_armor * 2
			ship_current_armor = 0
			take_damage(damage)
		else:
			ship_current_armor = ship_current_armor - round(damage / 2)
	elif ship_current_health > 0:
		if damage > ship_current_health:
			damage = damage - ship_current_health
			ship_current_health = 0
		else:
			ship_current_health = ship_current_health - damage
	
	$ShipUI.setStats(self.ship_name,self.ship_current_health, self.ship_health, self.ship_current_armor, self.ship_armor,self.ship_current_shield, self.ship_shield)

func build(ship):
	var shipPath = "res://Ships/" + ship + ".tscn"
	#	why does load work but not preload?
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
	
func enemy_turn():
	var enemy = self.get_parent().get_node("player")
	#enemy.take_damage(40)
	enemy.damage_step(40)

