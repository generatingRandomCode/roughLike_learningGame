extends State

#	Actions [action, cause, target]
#	gets a array of actions, sort them by init and executes them
func enter(parameter := {}) -> void:
	# wie sorg ich dafür das er für jedes schiff einmal 
	var actions = parameter["Actions"]
	await executeActions(actions)
	await clearZeroHealthShips()
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
		#	cehck if current action still exist and if not skip the action -> rebuild to while until all actions are done?
		if !checkActionCanExecute(action):
			continue
		get_tree().call_group("ShipUI", "updateShipUI")
		#	if new init round start remove all ships with zero health
		if(start < $BattleStep.getWepondInitative(action[0],action[1])):
			start = $BattleStep.getWepondInitative(action[0],action[1])
			print("getWepondInitative: ", start)
			await clearZeroHealthShips()
			await get_tree().create_timer(1).timeout
		
		if !checkActionCanExecute(action):
			continue

		#	call the battelstep with the action
		await cause.get_node(str(action[0])).action(action[2])
		get_tree().call_group("ShipUI", "updateShipUI")
		await get_tree().create_timer(.25).timeout

func checkActionCanExecute(action):
	var cause = instance_from_id(action[1])
	var target = instance_from_id(action[2])
	if !cause:
		return false
	if !cause.get_child_count():
		return false
	if !target:
		return false
	if !cause.get_child_count():
		return false
	return true

func clearZeroHealthShips():
	print("clearZeroHealthShips: statz")
	for ship in get_tree().get_nodes_in_group("ship"):
		print("clearZeroHealthShips: ",ship.name, " ", ship.ship_current_health)
		if !ship.checkHealthIsAboveZero():
			await ship.destroySelf()
	get_tree().call_group("ShipUI", "updateShipUI")

func sortActionsByInitative(actions):
	#	retrun true if greter
	#	so return -1 for lesser iniz
	actions.sort_custom(func(a, b): return $BattleStep.getWepondInitative(a[0],a[1]) < $BattleStep.getWepondInitative(b[0],b[1]))
	return actions


