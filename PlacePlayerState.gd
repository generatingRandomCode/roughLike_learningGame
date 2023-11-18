extends State

#	basic ship template
var base = preload("res://player_grid_base.tscn")
var playerGrid = preload("res://player_grid.tscn")
var shipTemplate = preload("res://test_ship_01.tscn")


var playerField
#	the player chosen ship
var shipName

#	regulates the placing of character ships
func enter(parameter := {}) -> void:
	shipName = parameter["shipName"] 
	print("enterPlaceShips")
	playerGrid = playerGrid.instantiate()
	main.add_child(playerGrid)
	playerField = main.get_node("PlayerGrid/Player")
	print("playerField: ", playerField.name)
	#	this is how 
	for place in playerField.get_children():
		place.connect("playerPlaced", playerPlaced)

func playerPlaced(name):
	print("playerPlace ", name)
	var shipInstance = shipTemplate.instantiate()
	shipInstance.build(shipName)
	shipInstance.add_to_group("player")
	playerField.get_node(str(name)).add_child(shipInstance)
	#	to only place one ship remove the clickBoxes after placements 
	playerField.get_parent().removeClickZones("Player")
	get_parent().transition_to("PlaceEnemyState")
	#	clear area3d

