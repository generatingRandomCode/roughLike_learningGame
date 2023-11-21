extends Node3D

var explosion = preload("res://Data/3DVisual/Explosion_Particle.tscn")


#	here are all the functions to calculate the damage
#	cause and target are the modell with the button
func executeAction(action, cause, target):
	print("battlestep")
	var damage = getWepondDamage(cause,action)
	if damage:
		damageCalculation(target, damage)

	
func getWepondDamage(cause,action):
	var ship = instance_from_id(cause)
	print("getWepondDamage shipName", ship)
	for x in ship.get_children():
		print(x)
		print("Action: ", action)
	var weponDamage = ship.get_node(str(action)).wepon_damage
	return weponDamage


func damageCalculation(targetID, damage):
	#	because template is equiped
	var target = instance_from_id(targetID)
	if target.ship_current_shield > 0:
		shildDamage(targetID, damage)
	elif target.ship_current_armor > 0:
		armorDamage(targetID, damage)
	else:
		healthDamage(targetID, damage)
	updateShipUI(targetID)
	
func armorDamage(targetID, damage):
	var target = instance_from_id(targetID)
	if target.ship_current_armor > 0:
		if damage > target.ship_current_armor * 2:
			damage = damage - target.ship_current_armor * 2
			target.ship_current_armor = 0
			damageCalculation(targetID,damage)
		else:
			target.ship_current_armor = target.ship_current_armor - round(damage / 2)
	

func shildDamage(targetID, damage):
	var target = instance_from_id(targetID)
	if target.ship_current_shield > 0:
		if damage >= target.ship_current_shield:
			damage = damage - target.ship_current_shield
			target.ship_current_shield = 0
			#	hide the shield when shield is zero
			target.get_node("Shield").hide()
			damageCalculation(targetID,damage)
		else:
			target.ship_current_shield = target.ship_current_shield - damage
	

func healthDamage(targetID, damage):
	var target = instance_from_id(targetID)
	if target.ship_current_health <= 0:
		destroyShip(targetID)
	elif damage >= target.ship_current_health:
		destroyShip(targetID)
	else:
		target.ship_current_health = max(0,target.ship_current_health - damage)

func destroyShip(targetID):
	print("destroy ship")
	var target = instance_from_id(targetID)
	var explosionInstance = explosion.instantiate()
	var node = target.get_parent()
	node.add_child(explosionInstance)
	#	remove ship
	#target.add_to_group("destroyed")
	#for x in target.get_children():
	#	target.remove_child(x)
	#	x.queue_free()
	node.remove_child(target)
	target.queue_free()

func updateShipUI(targetID):
	var target = instance_from_id(targetID)
	#	check if ship still exist after taking damage
	if target.has_node("ShipUI"):
		target.get_node("ShipUI").updateShipUI()
