extends State

#	Actions [action, cause, target]
#	gets a array of actions, sort them by init and executes them
func enter(parameter := {}) -> void:
	#var test = ActionTemplate.new("wasser")
	# wie sorg ich dafür das er für jedes schiff einmal 
	var actions : Array[Node] = parameter["Actions"]
	print("ActionTemplate: real", actions)
	#	bevor ich sie sortiere muss ich die init sortieren
	reInitizeActions(actions)
	actions = sortActionsByInitative(actions) 
	print("ActionTemplate: real ", actions)
	
	await executeActions(actions)
	await clearZeroHealthShips()
	get_parent().transition_to("CheckBoardState",{})

#	calls the functions 
func executeActions(actions : Array[Node]):
	#	sort action
	var start : int = 0
	var initStep : int = 0
	#for action in actions:
	while actions:
		var action = actions[0]
		get_tree().call_group("ShipUI", "updateShipUI")
		#	cehck if current action still exist and if not skip the action -> rebuild to while until all actions are done?
		print("field test: set field check1", action.action)
		#	check bevore ship is destroyed
		if !checkActionCanExecute(action):
			actions.erase(action)
			continue
		print("field test: set field check2", action.action)
		#	if new init round start remove all ships with zero health
		if(start < action.actionInitiative):
			start = action.actionInitiative
			await clearZeroHealthShips()
			await get_tree().create_timer(1).timeout
		#	check after ship destroyed
		if !checkActionCanExecute(action):
			actions.erase(action)
			continue

		#	call the battelstep with the action
		#pay energy cost
		await action.payActionShipEnergy()
		await action.executeAction()

		get_tree().call_group("ShipUI", "updateShipUI")
		#await get_tree().create_timer(.25).timeout
		actions.erase(action)

#	problem wie weiß ich beim überprüfen ob ich target oder targetFieldBrauche 
func checkActionCanExecute(action):
	var cause = action.cause
	var target = action.targets
	print("field test: check3", cause, " ", target)
	if !cause:
		return false
	if !cause.get_child_count():
		return false
#	#	check if target is required
	
	if action.needTarget:
		if !action.targets:
			return false
	#	check if the action needs a target field
	if action.needTargetField:
		if !action.targetField:
			return false 
	#check for energy
		#	check if you can pay the energy cost, if not pass or play animation
	if action.getActionShipEnergy() < action.energyCost:
		return false
	return true

func clearZeroHealthShips():
	print("clearZeroHealthShips: statz")
	for ship in get_tree().get_nodes_in_group("Ship"):
		if !ship:
			continue
		if !ship.checkHealthIsAboveZero():
			await ship.destroySelf()
	get_tree().call_group("ShipUI", "updateShipUI")

func sortActionsByInitative(actions : Array[Node])->Array[Node]:
	actions.sort_custom(func(a, b): return  a.actionInitiative < b.actionInitiative)
	return actions

func reInitizeActions(actions : Array[Node])->void:
	
	for x in actions.size():
		#	get the current cause
		var actionToCompare = actions[x].cause
		#	compare to the rest of the arrays:
		for y in actions.size():
			if y > x:
				if actionToCompare == actions[y].cause:
					actions[y].actionInitiative += actions[x].actionInitiative
				

