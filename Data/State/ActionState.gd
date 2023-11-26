extends State

#	this signal will be emitted at the end of the round to destroy all ships
signal checkForHealth

@onready var battleStep : Node3D = $BattleStep
#	Actions [action, cause, target]
#	gets a array of actions, sort them by init and executes them
func enter(parameter := {}) -> void:
	
	for ship in get_tree().get_nodes_in_group("Ship"):
		self.connect("checkForHealth", ship.checkForHealth)

	var actions : Array[Node] = parameter["Actions"]
	print("ActionTemplate: real", actions)
	#	bevor ich sie sortiere muss ich die init sortieren
	reInitizeActions(actions)
	actions = sortActionsByInitative(actions) 
	print("ActionTemplate: real ", actions)
	
	await executeActions(actions)
	checkForHealth.emit(true)
	#await clearZeroHealthShips()
	await clearBattlestep()
	#	wait for actions to conclude
	await get_tree().create_timer(.5).timeout
	get_tree().call_group("ShipUI", "updateShipUI")
	get_parent().transition_to("CheckBoardState",{})

#	calls the functions 
func executeActions(actions : Array[Node]):

	var MaxinitStep : int = 11
	var startInit = max(1,actions[0].actionInitiative - 1)
	
	var currentMaxInitStep = (actions[-1].actionInitiative) + 5
	for initStep in range( startInit ,currentMaxInitStep):
		#	sort the action and get a new end init to end the turn
		actions = sortActionsByInitative(actions)
		displayInitTimer(initStep)
		print("field test: set field check1", actions)
		#for action in actions:
		var actionCounter = 0
		while(actionCounter < actions.size()):
			var action = actions[actionCounter]
		#	cehck if current action still exist and if not skip the action -> rebuild to while until all actions are done?
		#	check bevore ship is destroyed
			if action.actionInitiative != initStep:
				actionCounter += 1
				continue
			#	check for valid action and delete if not
			if !checkActionCanExecute(action):
				actions.erase(action)
				continue
			await action.payActionShipEnergy()
			await action.executeAction()
			get_tree().call_group("ShipUI", "updateShipUI")
			actions.erase(action)
		#	end of a init step
		await get_tree().create_timer(1).timeout
		get_tree().call_group("ShipUI", "updateShipUI")
		checkForHealth.emit(false)
		if currentMaxInitStep == initStep:
			break
		#if !actions:
		#	break
func clearBattlestep()->void:
	for x in battleStep.get_children():
		battleStep.remove_child(x)
		x.queue_free()


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
	if !cause.ship_current_health:
		return false
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

func hideZeroHealthShips():
	for ship in get_tree().get_nodes_in_group("Ship"):
		if !ship:
			continue
		if !ship.checkHealthIsAboveZero():
			await ship.hideAndShowDestruction()
			
	get_tree().call_group("ShipUI", "updateShipUI")
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
				
func displayInitTimer(initStep: int):
	var turnLabel = main.get_node("StateMashine/InterTurnState/Panel/RichTextLabel")
	turnLabel.text = "init: " + str(initStep)
	turnLabel.show()

func exit():
	for ship in get_tree().get_nodes_in_group("Ship"):
		self.disconnect("checkForHealth", ship.checkForHealth)
