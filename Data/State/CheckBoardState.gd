extends State



#	this state fpr beginning will chose enemy stats at random
func enter(parameter := {}) -> void:
	print("enter checkBoardState")
	#await checkField()
	#var willContinue = checkPlayer()
	if !checkPlayer():
		await get_tree().create_timer(3).timeout
		get_tree().quit()
	elif checkEnemy():
		get_parent().transition_to("LevelEndState")
	else:
		get_parent().transition_to("InterTurnState",{})
		#await get_tree().create_timer(3).timeout
		#get_tree().quit()

func checkPlayer()->bool:
	var playerShips = get_tree().get_nodes_in_group("player")
	if !playerShips:
		return false
	else:
		return true
		
		
#	checks if there are still enemys
func checkEnemy()->bool:
	var enemyShips = get_tree().get_nodes_in_group("enemy")
	#	end the game if on of the fields is empty

	print("enemyShips: ", enemyShips)
	if !enemyShips:
		return false
	else:
		return true


