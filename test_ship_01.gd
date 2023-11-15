extends "res://shipTemplate.gd"





#	gets called when ship is init
func _ready():	
	print("_ready()");
	$damageText.hide()
	update_dispaly()
	
func build(name,health,armor,shield):
	self.ship_name = name
	self.ship_health = health
	self.ship_current_health = health
	self.ship_armor = armor
	self.ship_current_armor = armor
	self.ship_shield = shield
	self.ship_current_shield = shield
	update_dispaly()


func _on_attack_pressed():
	var test = self.get_parent().get_node("enemy").get("ship_current_shield")
	var enemy = self.get_parent().get_node("enemy")
	enemy.damage_step(60)

	print("current shild: " , test)
	enemy_turn()
	
func enemy_turn():
	var enemy = self.get_parent().get_node("player")
	#enemy.take_damage(40)
	enemy.damage_step(40)
