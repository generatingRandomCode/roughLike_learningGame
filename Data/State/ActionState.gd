extends State

var explosion = preload("res://Data/3DVisual/Explosion_Particle.tscn")
#	Actions [action, cause, target]
#	gets a array of actions, sort them by init and executes them
func enter(parameter := {}) -> void:
	# wie sorg ich dafür das er für jedes schiff einmal 
	var actions = parameter["Actions"]
	await executeActions(actions)
	await clearBoard(actions)
	get_parent().transition_to("CheckBoardState",{})

#	calls the functions 
func executeActions(actions):
	#	sort action
	actions = sortActionsByInitative(actions)
	print("Actions: real", actions)
	var start = 0
	for action in actions:
		var cause = instance_from_id(action[1])
		var target = instance_from_id(action[2])
		#	cehck if current action still exist
		#	check if ships still exist
		if !get_node_or_null(cause):
			continue
		if !cause.get_child_count():
			continue
		if !get_node_or_null(target):
			continue
		if !cause.get_child_count():
			continue

		get_tree().call_group("ShipUI", "updateShipUI")
		if(start < $BattleStep.getWepondInitative(action[0],action[1])):
			await get_tree().create_timer(1).timeout
			if !checkShipHasHealth(action[1]):
				destroyShip(action[1])
				continue
			if !checkShipHasHealth(action[2]):
				destroyShip(action[2])
				continue
		
		#	call the battelstep with the action
		await cause.get_node(str(action[0])).executeAction(action[2])
		
		await get_tree().create_timer(.25).timeout
		
		start = $BattleStep.getWepondInitative(action[0],action[1])
		
		get_tree().call_group("ShipUI", "updateShipUI")


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
	get_tree().call_group("ShipUI", "updateShipUI")

func checkShipHasHealth(shipID):
	var ship = instance_from_id(shipID)
	if !ship:
		return false
	#print("ShipsHealth: ", ship.ship_current_health)
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
	#	das ganze quee free zeug functioniert nicht wso wirklich
	if target:
		var node = target.get_parent()
		if node:
			node.add_child(explosionInstance)
	#	not removing player...
	target.destroySelf()
