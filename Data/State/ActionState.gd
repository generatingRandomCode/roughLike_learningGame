extends State

var explosion = preload("res://Data/3DVisual/Explosion_Particle.tscn")
#	Actions [action, cause, target]
#	gets a array of actions, sort them by init and executes them
func enter(parameter := {}) -> void:
	var actions = parameter["Actions"]
	print("Actions: ", actions)
	#
	main.get_node("ActionUI/ActionContainer").hide()
	main.get_node("ActionUI/Info").hide()
	main.get_node("ActionUI").hide()
	print("Enter ActionState")
	await executeActions(actions)
	await clearBoard(actions)	
	get_parent().transition_to("CheckBoardState",{})




#	calls the functions 
func executeActions(actions):
	#	sort action
	actions = sortActionsByInitative(actions)
	var start = 0
	for action in actions:
		#await destroyShip(action[1])
		var cause = instance_from_id(action[1])
		var target = instance_from_id(action[2])
		#	cehck if current action still exist
		#	check if ships still exist
		if !cause:
			continue
		if !cause.get_child_count():
			continue
		if !target:
			continue

		if(start < $BattleStep.getWepondInitative(action[0],action[1])):
			await get_tree().create_timer(1).timeout
			if !checkShipHasHealth(action[1]):
				destroyShip(action[1])
				continue
			if !checkShipHasHealth(action[2]):
				destroyShip(action[2])
				continue

		await $BattleStep.executeAction(action[0],action[1],action[2])
		await get_tree().create_timer(.25).timeout
		start = $BattleStep.getWepondInitative(action[0],action[1])
		#	durch await wird gewartet bis die function fertig ist, dadurch ist das schiff in der lage entfernt zu werden und das spiel schließt sich
		#	wait for 1 second

func clearBoard(actions):
	for action in actions:	
		if !instance_from_id(action[1]):
			continue
		if !instance_from_id(action[2]):
			continue
		if !checkShipHasHealth(action[1]):
			destroyShip(action[1])

		if !checkShipHasHealth(action[2]):
			destroyShip(action[2])

func checkShipHasHealth(shipID):
	var ship = instance_from_id(shipID)
	print("ShipsHealth: ", ship.ship_current_health)
	if !ship:
		return false
	if ship.ship_current_health > 0:
		return true
	return false
	

func sortActionsByInitative(actions):
	#	retrun true if greter
	#	so return -1 for lesser iniz
	actions.sort_custom(func(a, b): return $BattleStep.getWepondInitative(a[0],a[1]) < $BattleStep.getWepondInitative(b[0],b[1]))
	return actions


func destroyShip(targetID):
	var target = instance_from_id(targetID)
	print("destroy ship")
	#var target = instance_from_id(targetID)
	var explosionInstance = explosion.instantiate()
	var node = target.get_parent()
	if node:
		node.add_child(explosionInstance)
	#	not removing player...
	target.destroySelf()
