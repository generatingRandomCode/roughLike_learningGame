extends "res://shipTemplate.gd"

#include("res://ship_ui.gd")

#	later preload the specific  ship
var ship

#	gets called when ship is init
func _ready():
	print("_ready()");
	$ShipUI.setStats(self.ship_name,self.ship_current_health, self.ship_health, self.ship_current_armor, self.ship_armor,self.ship_current_shield, self.ship_shield)
	$ShipUI/Action.hide()
	
	#var shipUi = $ShipUi
	#shipUi = shipUi.instantiate() 

#	Inits the ship from the ship builder with the name of the ship from the ship libary
func build(ship):
	var shipPath = "res://Ships/" + ship + ".tscn"
	#	why does load work but not preload?
	ship = load(shipPath)
	ship = ship.instantiate()
	ship.name = "Model"
	add_child(ship)
	self.ship_name = $Model.shipName
	self.ship_health = $Model.shipHealth
	self.ship_current_health = $Model.shipHealth
	self.ship_armor = $Model.shipArmor
	self.ship_current_armor = $Model.shipArmor
	self.ship_shield = $Model.shipShield
	self.ship_current_shield = $Model.shipShield
	$ShipUI.setStats(self.ship_name,self.ship_current_health, self.ship_health, self.ship_current_armor, self.ship_armor,self.ship_current_shield, self.ship_shield)


#func _on_attack_pressed():
#	var test = self.get_parent().get_node("enemy").get("ship_current_shield")
#	var enemy = self.get_parent().get_node("enemy")
#	enemy.damage_step(60)

#	print("current shild: " , test)
#	enemy_turn()
	
func enemy_turn():
	var enemy = self.get_parent().get_node("player")
	#enemy.take_damage(40)
	enemy.damage_step(40)
