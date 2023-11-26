extends State

#	this state chooses the player ship and the campaing that shoud be player, so here comes what is loaded next after completing the leverl


func _ready():
	main.gridY = 3
	main.gridX = 3

func enter(_msg := {}) -> void:

	if main.gamestart:
		main.currentCampaign = $Campaign
		get_parent().transition_to("ChooseShipToPlace",{"Number": 1})
	else:
		get_parent().transition_to("PlaceSafedShipsState")

	#get_parent().transition_to("ChooseShipNumberState")
	#get_parent().transition_to("PlacePlayerState",{"shipName" : playerShips[0]})
	#get_parent().transition_to("ChooseBoardSizeState")

func exit():
	main.currentLevel = $Campaign.levels[main.currentLevelCount]
	main.gamestart = false
