extends State


func enter(parameter = {}):
	main.playerMoney += main.currentLevel.lootMoney
	main.currentLevelCount += 1
	#	clear board
	#	safe the player ships for the next round
	var playerShips = get_tree().get_nodes_in_group("player")
	for ship in playerShips:
		ship.get_parent().remove_child(ship)
		main.get_node("SafePlayerShips").add_child(ship)


	await main.get_node("PlayerGrid").queue_free()
	
	if main.currentLevelCount  == main.currentCampaign.levels.size():
		await get_tree().create_timer(1).timeout
		get_tree().quit()
	else:
		get_parent().transition_to("CreateCampaignState",{"next" : true})
