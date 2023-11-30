extends State



#	this state fpr beginning will chose enemy stats at random
func enter(parameter := {}) -> void:
	print("enter checkBoardState")
	#await checkField()
	#var willContinue = checkPlayer()
	if !checkPlayer():
		await get_tree().create_timer(3).timeout
		get_tree().quit()
	elif !checkEnemy():
		safePlayerShipsAtCombatEnd()
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


func safePlayerShipsAtCombatEnd():
	var playerShips = get_tree().get_nodes_in_group("player")
	for ship in playerShips:
		print("shippath: ", ship.get_parent().get_path())		
		main.playerShips += [ship.get_parent().get_path()]
		ship.get_parent().remove_child(ship)
		main.get_node("SafePlayerShips").add_child(ship)

	var playerGrid = main.get_node("PlayerGrid")
	main.remove_child(main.get_node("PlayerGrid"))
	playerGrid.queue_free()
