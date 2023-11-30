extends State


func enter(parameter = {}):
	#	increase the levelcap
	main.playerMoney += main.currentLevel.lootMoney
	main.currentLevelCount += 1
	#	clear board
	#	safe the player ships for the next round
	#	end the game if there are no more levels
	if main.currentLevelCount  == main.currentCampaign.levels.size():
		await get_tree().create_timer(1).timeout
		get_tree().quit()
	else:
		get_parent().transition_to("CreateCampaignState",{"next" : true})

