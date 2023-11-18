extends State

#	This state handles the start menu and the player placement 

#var playerGrid = preload("res://player_grid.tscn")

#	main node
var main

#	this function is called when the state is entered
#	show the menu
func enter(_msg := {}) -> void:
	main = get_tree().get_root().get_node("main")
	#print("main node:", main.name)
	#for x in main.get_children():
	#	print(x.name)
	main.get_node("Menu").show()
	print("gameStart")
	main.connect("start_pressed", startPressed)

#	load playerfield 
func startPressed():
	print("connected signal")
	#$"../../Menu".hide()
	main.get_node("Menu").hide()
	get_parent().transition_to("PlacePlayerState")
	#playerGrid = playerGrid.instantiate()
	#main.add_child(playerGrid)
	#	scene transition to place ship scene
	

	
