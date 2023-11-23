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
		if !checkActionCanExecute(action):
			continue

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
	if !cause:
		return false
	if !cause.get_child_count():
		return false
	
	if action.needTarget:
		if !target:
			return false
		if !target.get_child_count():
			return false
	return true

func clearZeroHealthShips():
	print("clearZeroHealthShips: statz")
	for ship in get_tree().get_nodes_in_group("ship"):
		#print("clearZeroHealthShips: ",ship.name, " ", ship.ship_current_health)
		if !ship:
			continue
		if !ship.checkHealthIsAboveZero():
			await ship.destroySelf()
	get_tree().call_group("ShipUI", "updateShipUI")

func sortActionsByInitative(actions):
	#	retrun true if greter
	#	so return -1 for lesser iniz
	#actions.sort_custom(func(a, b): return $BattleStep.getWepondInitative(a[0],a[1]) < $BattleStep.getWepondInitative(b[0],b[1]))
	actions.sort_custom(func(a, b): return  a.actionInitiative < b.actionInitiative)
	return actions


