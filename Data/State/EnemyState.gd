extends State
#enum TargetPreselectionPatterns{Enemy = 0, Self = 1, FreeSpace = 2} -> og
enum TargetPreselectionPatterns{Enemy = 0, Self = 1, FreeSpace = 2}
#	this state fpr beginning will chose enemy stats at random
func enter(parameter := {}) -> void:
	print("Enter enemyState")
	
	var actions = parameter["Actions"]
	
	actions += enemyAttack()
	
	print("actions: ", actions)
	get_parent().transition_to("ActionState",{"Actions": actions})
	actions = {}

#	enemy  target groups sind genau andersherum, sie schießen auf den spieler und nicht auf sich selbst
func enemyAttack():
	var actions = []
	var enemyShips = get_tree().get_nodes_in_group("enemy")

	for ship in enemyShips:
		var wepons = getWeponForShip(ship)
		var random_wepon = randi() % wepons.size()
		var action = wepons[random_wepon]
		var newAction = ActionTemplate.new()
		newAction.getActionFromObj(action)
		actions += [newAction]
		var random_target = randi() % getTargetGroup(actions[-1]).size()
		actions[-1].setTargetsFromFieldOBJ(getTargetGroup(actions[-1])[random_target])
	return actions

func getWeponForShip(enemyShip):
	return enemyShip.actions
	
func getTargetGroup(action)-> Array:
	match(action.targetPreselection):
		#	all enenmy
		TargetPreselectionPatterns.Enemy:
			return get_tree().get_nodes_in_group("player").map(func(x): return x.get_parent())
		#	self
		TargetPreselectionPatterns.Self:
			return [action.cause.get_parent()]
		#	get the free player board
		TargetPreselectionPatterns.FreeSpace:
			return get_tree().get_nodes_in_group("EnemyField").filter(
				func(a): return !a.has_node("Model")
			)
		_:
			return []
