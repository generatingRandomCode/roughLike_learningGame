extends Node3D





#	here are all the functions to calculate the damage
#	cause and target are the modell with the button
func executeAction(action, cause, target):
	print("battlestep")
	var damage = getWepondDamage(action,cause)
	if damage:
		damageCalculation(target, damage)

func getWepondInitative(action,cause):
	var ship = instance_from_id(cause)
	return ship.get_node(str(action)).wepon_initiative


	
func getWepondDamage(action,cause):
	var ship = instance_from_id(cause)
	if ship:
		print("getWepondDamage shipName", ship)
		return ship.get_node(str(action)).wepon_damage
	else:
		print("no ship for damage")
		return 0


func damageCalculation(targetID, damage):
	#	because template is equiped
	var target = instance_from_id(targetID)
	if target.ship_current_shield > 0:
		await shildDamage(targetID, damage)
	elif target.ship_current_armor > 0:
		await armorDamage(targetID, damage)
	else:
		await healthDamage(targetID, damage)
	await updateShipUI(targetID)
	
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
	#if target.ship_current_health <= 0:
	target.ship_current_health = max(0,target.ship_current_health - damage)
		#destroyShip(targetID)
	#elif damage >= target.ship_current_health:
		#destroyShip(targetID)
	#else:



func updateShipUI(targetID):
	var target = instance_from_id(targetID)
	#	check if ship still exist after taking damage
	if target.has_node("ShipUI"):
		target.get_node("ShipUI").updateShipUI()
