extends State

#	This state handles the start menu and the player placement 

#var playerGrid = preload("res://player_grid.tscn")

#	main node

#	this function is called when the state is entered
#	show the menu
func enter(_msg := {}) -> void:
	main.get_node("StartMenu").show()
	print("gameStart")

#	load playerfield 
func startPressed(name):
	print("connected signal: ", name)
	main.get_node("StartMenu").hide()
	get_parent().transition_to("PlacePlayerState",{"shipName" : name})
	

	
