extends State

#	This state handles the start menu and the player placement 
#	this function is called when the state is entered
#	show the menu
func enter(_msg := {}) -> void:
	main.get_node("StartMenu").show()

#	load playerfield 
func startPressed(buttonID):
	main.get_node("StartMenu").hide()

	print("button Name: ",buttonID )
	var shipName = instance_from_id(buttonID)
	shipName = shipName.name
	get_parent().transition_to("PlacePlayerState",{"shipName" : shipName})
	

	
