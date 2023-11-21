extends Node3D

var explosion = preload("res://Data/3DVisual/Explosion_Particle.tscn")

func executeActions(actions):
	#	sort action
	actions = sortActionsByInitative(actions)
	
	for action in actions:
		#	durch await wird gewartet bis die function fertig ist, dadurch ist das schiff in der lage entfernt zu werden und das spiel schließt sich
		executeAction(action[0],action[1],action[2])
		await get_tree().create_timer(1).timeout
		#	wait for 1 second

func sortActionsByInitative(actions):
	#	retrun true if greter
	#	so return -1 for lesser iniz
	actions.sort_custom(func(a, b): return getWepondInitative(a[0],a[1]) < getWepondInitative(b[0],b[1]))
	return actions

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
		var weponDamage = ship.get_node(str(action)).wepon_damage
		return weponDamage
	else:
		print("no ship for damage")
		return 0


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
	#	not removing player...
	target.destroySelf()

func updateShipUI(targetID):
	var target = instance_from_id(targetID)
	#	check if ship still exist after taking damage
	if target.has_node("ShipUI"):
		target.get_node("ShipUI").updateShipUI()
