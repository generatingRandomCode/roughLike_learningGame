extends State



#	this state fpr beginning will chose enemy stats at random
func enter(parameter := {}) -> void:
	print("enemyState")
	enemyAttack()
	get_parent().transition_to("ChooseActionState",{})
	


func enemyAttack():
	var enemyShips = getEnemyShips()
	var playerShips = getPlayerShips()
	for ship in enemyShips:
		var wepons = getWeponForShip(ship)
		var random_wepon = randi() % wepons.size()
		var random_target = randi() % playerShips.size()
		var cause = ship.get_node("Model").get_instance_id()
		var target = playerShips[random_target].get_node("Model").get_instance_id()
		var action = wepons[random_wepon].name
		$"../ActionState/BattleStep".executeAction(cause,target,action)

func getEnemyShips():
	return get_tree().get_nodes_in_group("enemy")
			
func getWeponForShip(enemyShip):
	return enemyShip.get_node("Model").wepons

func getPlayerShips():
	return get_tree().get_nodes_in_group("player")
	
