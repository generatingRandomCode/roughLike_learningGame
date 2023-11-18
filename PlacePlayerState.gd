extends State

#	basic ship template
var base = preload("res://player_grid_base.tscn")
var playerGrid = preload("res://player_grid.tscn")
var shipTemplate = preload("res://test_ship_01.tscn")

var main
var playerField
#	regulates the placing of character ships
func enter(_msg := {}) -> void:
	main = get_tree().get_root().get_node("main")
	print("enterPlaceShips")
	#main.connect("player_place", signalPlayerPlaced)
	playerGrid = playerGrid.instantiate()
	main.add_child(playerGrid)
	playerField = main.get_node("PlayerGrid/Player")
	print("playerField: ", playerField.name)
	for place in playerField.get_children():
		place.connect("playerPlaced", playerPlaced)
	#	this shoud connect to the signal emmited by the shipPlacedSignal
	#	connected to player span system
	#main.connect("start_pressed", startPressed)
	#playerPlaced
	

func playerPlaced(name):
	print("playerPlace ", name)
	var shipInstance = shipTemplate.instantiate()
	shipInstance.build("Player Ship",100,100,100)
	#$Area3D.queue_free()
	#shipInstance.rotate(Vector3(0,1,0), PI*1.5)
	playerField.get_node(str(name)).add_child(shipInstance)
#	for i in playerField.get_children():
#		print("child: ",i.name)
