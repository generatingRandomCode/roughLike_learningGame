extends State



#	this state fpr beginning will chose enemy stats at random
func enter(parameter := {}) -> void:
	print("enter checkBoardState")
	await checkField()
	get_parent().transition_to("InterTurnState",{})


#	checks if there are still enemys
func checkField():
	var enemyShips = get_tree().get_nodes_in_group("enemy")
	var playerShips = get_tree().get_nodes_in_group("player")
	#	end the game if on of the fields is empty
	print("playerShips: ", playerShips)
	print("enemyShips: ", enemyShips)
	if !playerShips:
		await get_tree().create_timer(3).timeout
		get_tree().quit()
	if !enemyShips:
		await get_tree().create_timer(3).timeout
		get_tree().quit()


