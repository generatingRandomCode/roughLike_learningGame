extends State

var base = preload("res://player_grid_base.tscn")
var playerGrid = preload("res://player_grid.tscn")

var playerField
#	the player chosen ship
var shipName

#	regulates the placing of character ships
func enter(parameter := {}) -> void:
	shipName = parameter["shipName"] 
	print("enterPlaceShips")
	#	create player grid
	if !main.has_node("PlayerGrid"):
		var playerGridInstance = playerGrid.instantiate()
		main.add_child(playerGridInstance)
	#	
	playerField =get_tree().get_nodes_in_group("PlayerField")
	#	this is how 
	for place in playerField:
		if !place.has_node("Model"):
			place.connect("fieldSelect", playerPlaced)

func playerPlaced(gridID):
	#	get the grid by nodeID
	var grid = instance_from_id(gridID)
	#	creat a ship instance and add to the grid field
	#	get the tcen after player name 
	#	get the ship name from the ShipName
	var shipPath = "res://Ships/" + shipName + ".tscn"
	#	why does load work but not preload?
	#	get ship
	var ship = load(shipPath)
	var shipInstance = ship.instantiate()
	shipInstance.add_to_group("player")
	grid.add_child(shipInstance)
	#	to only place one ship remove the clickBoxes after placements 
	
	for place in playerField:
		if place.is_connected("fieldSelect",playerPlaced):
			place.disconnect("fieldSelect",playerPlaced)
	
	get_parent().transition_to("ChooseShipToPlace")


