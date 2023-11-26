extends State



#	this state fpr beginning will chose enemy stats at random
func enter(parameter := {}) -> void:
	print("enter checkBoardState")
	#await checkField()
	var willContinue = checkField()
	if willContinue:
		get_parent().transition_to("InterTurnState",{})
	else:
		await get_tree().create_timer(3).timeout
		get_tree().quit()


#	checks if there are still enemys
func checkField()->bool:
	var enemyShips = get_tree().get_nodes_in_group("enemy")
	var playerShips = get_tree().get_nodes_in_group("player")
	#	end the game if on of the fields is empty
	print("playerShips: ", playerShips)
	print("enemyShips: ", enemyShips)
	if !playerShips or !enemyShips:
		return false
	else:
		return true


