extends Node3D


#	here are all the functions to calculate the damage
#	cause and target are the modell with the button
func executeAction(cause, target,action):
	print("battlestep")
	var damage = getWepondDamage(cause,action)
	if damage:
		damageCalculation(target, damage)

	
func getWepondDamage(cause,action):
	var ship = instance_from_id(cause)
	var weponDamage = ship.get_node(str(action)).wepon_damage
	return weponDamage


func damageCalculation(targetID, damage):
	#	because template is equiped
	var target = instance_from_id(targetID)
	if target.ship_current_shield > 0:
		if damage > target.ship_current_shield:
			damage = damage - target.ship_current_shield
			target.ship_current_shield = 0
			damageCalculation(targetID,damage)
		else:
			target.ship_current_shield = target.ship_current_shield - damage
	elif target.ship_current_armor > 0:
		if damage > target.ship_current_armor * 2:
			damage = damage - target.ship_current_armor * 2
			target.ship_current_armor = 0
			damageCalculation(targetID,damage)
		else:
			target.ship_current_armor = target.ship_current_armor - round(damage / 2)
	elif target.ship_current_health > 0:
		if damage > target.ship_current_health:
			damage = damage - target.ship_current_health
			target.ship_current_health = 0
		else:
			target.ship_current_health = target.ship_current_health - damage
	updateShipUI(targetID)	


func updateShipUI(targetID):
	var target = instance_from_id(targetID)
	target.get_node("ShipUI").updateShipUI()
