extends State

func enter(parameter := {}) -> void:
	main.get_node("ActionUI/ActionContainer").hide()
	main.get_node("ActionUI/Info").hide()
	main.get_node("ActionUI").hide()
	print("ActionState")
	var actionName = parameter["ActionName"] 
	var actionCause = parameter["ActionCause"] 
	var actionTarget = parameter["ActionTarget"]
	print(actionName,actionCause,actionTarget)
	$BattleStep.executeAction(actionCause,actionTarget,actionName)
	
