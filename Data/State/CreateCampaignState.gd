extends State

#	this state chooses the player ship and the campaing that shoud be player, so here comes what is loaded next after completing the leverl


func _ready():
	main.gridY = 3
	main.gridX = 3

func enter(_msg := {}) -> void:
	
	#	check if the player board allready exist
	#	start first level with placing a ship
	if main.gamestart:
		main.currentCampaign = $Campaign
		get_parent().transition_to("ChooseShipToPlace",{"Number": 1})
	else:
		#	continue with fleet 
		get_parent().transition_to("BuildLevelState")

	#get_parent().transition_to("ChooseShipNumberState")
	#get_parent().transition_to("PlacePlayerState",{"shipName" : playerShips[0]})
	#get_parent().transition_to("ChooseBoardSizeState")

func exit():
	#	set the new campaign level to load
	main.currentLevel = $Campaign.levels[main.currentLevelCount]
	#	set gamestart to false after first loop
	main.gamestart = false
