extends State



#	this state fpr beginning will chose enemy stats at random
func enter(parameter := {}) -> void:
	print("enter checkBoardState")
	checkField()


#	checks if there are still enemys
func checkField():
	var enemyShips = get_tree().get_nodes_in_group("enemy")
	var playerShips = get_tree().get_nodes_in_group("player")
	if playerShips and enemyShips:
		get_parent().transition_to("ChoosePlayerState",{})
	else:
		get_tree().quit()

