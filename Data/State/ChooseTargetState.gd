extends PlayerTurnState

var actionName
var actionCause
var actions


var icon = preload("res://Data/3DVisual/3DAttackSelector.tscn")


#	State to enter when choosing an action for a ship
func enter(parameter := {}) -> void:
	if parameter.has("Actions"):
		actions = parameter["Actions"]
	print("Actions array: target start", actions)
	if !get_parent().actionsLeft:
		get_parent().actionsLeft = get_tree().get_nodes_in_group("player")
	
	
	actionName = parameter["ActionName"] 
	actionCause = parameter["ActionCause"] 
	#main.get_node("ActionUI/Info").text = "Choose Target to shoot with " + actionName + "!"
	#main.get_node("ActionUI/Info").show()
		#connect to all enemy ships
	var enemyShips = get_tree().get_nodes_in_group("enemy")
	await displayTargetIcon()
	for x in enemyShips:
		if x.get_child_count():
			if !x.is_connected("shipClicked" ,targetShip):
				#	die ui zum klicken sitzt auf modell, das muss ich mal ändern damit ich die schiffe besser bauen kann
				x.connect("shipClicked" ,targetShip)
	

#	Ziel symbole, später abhängig davon 
func displayTargetIcon():
	var enemyShips = get_tree().get_nodes_in_group("enemy")
	print("enemyTest ", enemyShips)
	for x in enemyShips:
		if !x.has_node("AttackSelection"):
			var iconInstance = icon.instantiate()
			x.add_child(iconInstance)

func freeTargetIcon():
	var enemyShips = get_tree().get_nodes_in_group("enemy")
	for x in enemyShips:
		if x.has_node("AttackSelection"):
			x.get_node("AttackSelection").queue_free()
	
func targetShip(targetID):
	print("targetShip")
	var enemyShips = get_tree().get_nodes_in_group("enemy")
	#	als action class die classe an sich übergeben
	for x in enemyShips: 
		x.disconnect("shipClicked",targetShip)

	freeTargetIcon()
	if actions:
		actions += [[actionName,actionCause,targetID]]
	else:
		actions = [[actionName,actionCause,targetID]]
	#	delete the action
	get_parent().actionsLeft.erase(instance_from_id(actionCause))
	print("Actions array: target", actions)
	if(get_parent().actionsLeft.size() > 0):
		await state_machine.transition_to("PlayerTurnState",{"Actions" = actions})
	else:
		await state_machine.transition_to("EnemyState",{"Actions" = actions})
	actions = {}
