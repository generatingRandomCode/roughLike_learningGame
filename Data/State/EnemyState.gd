extends State



#	this state fpr beginning will chose enemy stats at random
func enter(parameter := {}) -> void:
	print("Enter enemyState")
	
	var actions = parameter["Actions"]
	
	actions += enemyAttack()
	
	print("actions: ", actions)
	get_parent().transition_to("ActionState",{"Actions": actions})
	actions = {}
	

func enemyAttack():
	var actions = []
	var enemyShips = getEnemyShips()
	var playerShips = getPlayerShips()
	for ship in enemyShips:
		var wepons = getWeponForShip(ship)
		var random_wepon = randi() % wepons.size()
		var random_target = randi() % playerShips.size()
		var cause = ship.get_instance_id()
		var target = playerShips[random_target].get_instance_id()
		var action = wepons[random_wepon].get_instance_id()
		
		actions += [ActionTemplate.new(action,cause,target)]
	return actions

func getEnemyShips():
	return get_tree().get_nodes_in_group("enemy")
			
func getWeponForShip(enemyShip):
	return enemyShip.actions

func getPlayerShips():
	return get_tree().get_nodes_in_group("player")
	
