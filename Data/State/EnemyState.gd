extends State

#	this state fpr beginning will chose enemy stats at random
func enter(parameter := {}) -> void:
	print("Enter enemyState")
	
	#var actions : Array[Node] = parameter["Actions"]
	
	var actions : Array[Node] = enemyAttack()
	
	print("new Actions: enemy", actions)
	get_parent().transition_to("PlayerTurnState",{"Actions": actions})

#	enemy  target groups sind genau andersherum, sie schießen auf den spieler und nicht auf sich selbst
func enemyAttack() ->Array[Node]:
	var actions  : Array[Node] = []
	var enemyShips = get_tree().get_nodes_in_group("enemy")
	#var playerShipsFields = get_tree().get_nodes_in_group("player").map(func(x): return x.get_parent())
	for ship in enemyShips:
		var wepons = ship.actions
		var random_wepon = randi() % wepons.size()
		var action = wepons[random_wepon]
		#action.targetPreselection = 3
		var newAction = ActionTemplate.new()
		newAction.getActionFromObj(action)
		actions += [newAction]
		var targets = actions[-1].getTargetGroup()
		if targets:
			var random_target = randi() % targets.size()
			actions[-1].setTargetsFromFieldOBJ(targets[random_target])
		#var random_target = randi() % actions[-1].getTargetGroup().size()
		
		
		#actions[-1].setTargetsFromFieldOBJ(actions[-1].getTargetGroup()[random_target])
	return actions
