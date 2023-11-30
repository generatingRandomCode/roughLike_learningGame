extends State

func enter(_msg := {}) -> void:
	
	
	
	if main.currentLevel.isCombatLevel():
		get_parent().transition_to("PlaceSafedShipsState")
	#	load the händler
	else:
		get_parent().transition_to("TraderState")

	#get_parent().transition_to("ChooseShipNumberState")
	#get_parent().transition_to("PlacePlayerState",{"shipName" : playerShips[0]})
	#get_parent().transition_to("ChooseBoardSizeState")
