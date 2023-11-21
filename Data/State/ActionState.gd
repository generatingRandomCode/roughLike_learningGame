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
	await $BattleStep.executeActions(actions)
	#for action in actions:
	#	$BattleStep.executeAction(action[0],action[1],action[2])
	#	#	wait for 1 second
	#	await get_tree().create_timer(0.1).timeout	
	get_parent().transition_to("CheckBoardState",{})

#	get the initative of each weapon
