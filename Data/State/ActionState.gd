extends State

#	Actions [action, cause, target]
#	gets a array of actions, sort them by init and executes them
func enter(parameter := {}) -> void:
	#var test = ActionTemplate.new("wasser")
	# wie sorg ich dafür das er für jedes schiff einmal 
	var actions = parameter["Actions"]
	print("ActionTemplate: real", actions)
	actions = sortActionsByInitative(actions)
	print("ActionTemplate: real ", actions)
	for x in actions:
		print("ActionTemplate: real ", x.actionInitiative)
	
	await executeActions(actions)
	await clearZeroHealthShips()
	get_parent().transition_to("CheckBoardState",{})

#	calls the functions 
func executeActions(actions):
	#	sort action
	var start = 0
	for action in actions:
		get_tree().call_group("ShipUI", "updateShipUI")
		#	cehck if current action still exist and if not skip the action -> rebuild to while until all actions are done?
		print("field test: set field check1", action.action)
		if !checkActionCanExecute(action):
			continue
		print("field test: set field check2", action.action)
		#	if new init round start remove all ships with zero health
		if(start < action.actionInitiative):
			start = action.actionInitiative
			print("getWepondInitative: ", start)
			await clearZeroHealthShips()
			await get_tree().create_timer(1).timeout
		
		if !checkActionCanExecute(action):
			continue

		#	call the battelstep with the action
		await action.executeAction()
		get_tree().call_group("ShipUI", "updateShipUI")
		await get_tree().create_timer(.25).timeout

func checkActionCanExecute(action):
	var cause = action.cause
	var target = action.targets
	print("field test: check3", cause, " ", target)
	if !cause:
		return false
	if !cause.get_child_count():
		return false

	if action.needTarget:
		if (!action.targets) and (!action.targetField):
			return false
		#if !target.get_child_count():
			#return false
	return true

func clearZeroHealthShips():
	print("clearZeroHealthShips: statz")
	for ship in get_tree().get_nodes_in_group("Ship"):
		if !ship:
			continue
		if !ship.checkHealthIsAboveZero():
			await ship.destroySelf()
	get_tree().call_group("ShipUI", "updateShipUI")

func sortActionsByInitative(actions):
	actions.sort_custom(func(a, b): return  a.actionInitiative < b.actionInitiative)
	return actions


