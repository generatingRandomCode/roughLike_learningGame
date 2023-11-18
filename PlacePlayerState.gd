extends State


var playerGrid = preload("res://player_grid.tscn")
var main
#	regulates the placing of character ships
func enter(_msg := {}) -> void:
	main = get_tree().get_root().get_node("main")
	print("enterPlaceShips")
	#main.connect("player_place", signalPlayerPlaced)
	playerGrid = playerGrid.instantiate()
	main.add_child(playerGrid)
	#	this shoud connect to the signal emmited by the shipPlacedSignal
	#main.connect("start_pressed", startPressed)

