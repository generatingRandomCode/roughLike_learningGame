extends State

#	gets a array of actions, sort them by init and executes them
func enter(parameter := {}) -> void:
	var actions = parameter["Actions"]
	print("Actions: ", actions)
	#
	main.get_node("ActionUI/ActionContainer").hide()
	main.get_node("ActionUI/Info").hide()
	main.get_node("ActionUI").hide()
	print("Enter ActionState")


	for action in actions:
		$BattleStep.executeAction(action[0],action[1],action[2])
		#	wait for 1 second
		await get_tree().create_timer(1).timeout
		
	get_parent().transition_to("CheckBoardState",{})
	
		
		
func freeTargetIcon():
	var enemyShips = get_tree().get_nodes_in_group("enemy")
	for x in enemyShips:
		if x.get_child_count():
			x.get_node("AttackSelection").queue_free()
	
