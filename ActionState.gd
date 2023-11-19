extends State

func enter(parameter := {}) -> void:
	freeTargetIcon()
	main.get_node("ActionUI/ActionContainer").hide()
	main.get_node("ActionUI/Info").hide()
	main.get_node("ActionUI").hide()
	print("ActionState")
	var actionName = parameter["ActionName"] 
	var actionCause = parameter["ActionCause"] 
	var actionTarget = parameter["ActionTarget"]
	print(actionName,actionCause,actionTarget)
	if actionName and actionCause and actionTarget:
		$BattleStep.executeAction(actionCause,actionTarget,actionName)
		
	get_parent().transition_to("EnemyState",{})
	
		
		
func freeTargetIcon():
	var enemyShips = get_tree().get_nodes_in_group("enemy")
	for x in enemyShips:
		if x.get_child_count():
			x.get_node("AttackSelection").queue_free()
	
