extends "res://shipTemplate.gd"

#include("res://ship_ui.gd")


#var shipUi = preload("res://ship_ui.gd")



#	gets called when ship is init
func _ready():	
	print("_ready()");
	$ShipUI.setStats(self.ship_name,self.ship_current_health, self.ship_health, self.ship_current_armor, self.ship_armor,self.ship_current_shield, self.ship_shield)
	#var shipUi = $ShipUi
	#shipUi = shipUi.instantiate() 
	
func build(name,health,armor,shield):
	self.ship_name = name
	self.ship_health = health
	self.ship_current_health = health
	self.ship_armor = armor
	self.ship_current_armor = armor
	self.ship_shield = shield
	self.ship_current_shield = shield
	#self.shipUI.setStats(self.ship_name,self.ship_health,self.ship_armor, self.ship_shield)
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
