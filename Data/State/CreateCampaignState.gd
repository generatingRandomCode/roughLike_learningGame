extends State

#	this state chooses the player ship and the campaing that shoud be player, so here comes what is loaded next after completing the leverl

@onready main.gridX = 3
@onready main.gridY = 3

func enter(_msg := {}) -> void:
	#	init the basic campaing data and store it somwhere
	main.gridX = 3
	main.gridY = 3
	#var currentLevel = BaseLevel.new()
	#currentLevel.enemyShipsNames = ["TheLavoisier"]
	#currentLevel.enemyPosition = [[1,1]]
	main.currentCampaign = $Campaign
	
	main.currentLevel = $Campaign.levels[main.currentLevelCount]
	get_parent().transition_to("ChooseShipToPlace",{"Number": 1})
	#get_parent().transition_to("ChooseShipNumberState")
	#get_parent().transition_to("PlacePlayerState",{"shipName" : playerShips[0]})
	#get_parent().transition_to("ChooseBoardSizeState")

