extends State

var playerGrid = preload("res://player_grid.tscn")

#this class gets the safed ships and lets you replace them
func enter(parameter = {}):
	
	#	load a new player grid
	if !main.has_node("PlayerGrid"):
		var playerGridInstance = playerGrid.instantiate()
		main.add_child(playerGridInstance)
	#	connct the player field
	for grid in get_tree().get_nodes_in_group("PlayerField"):
		if !grid.has_node("Model"):
			grid.connect("fieldSelect", playerPlaced)

func playerPlaced(gridID):
	#	get the grid by nodeID
	var grid = instance_from_id(gridID)
	#	remove the placeholder example
	grid.get_node("Ship").queue_free()
	#	disconnect the button
	grid.disconnect("fieldSelect",playerPlaced)
	#	get shipFrom safed ships
	var savedShip = main.get_node("SafePlayerShips").get_children()[0]
	savedShip.add_to_group("player")
	#	name it modell because it was renamed when safed
	savedShip.name = "Model"
	main.get_node("SafePlayerShips").remove_child(savedShip)
	grid.add_child(savedShip)
	#	transition and remove the click fields
	if !main.get_node("SafePlayerShips").get_child_count():
		main.get_node("PlayerGrid").removeClickZones("PlayerField")
		get_parent().transition_to("PlaceEnemyState")

func exit():
	#	disconnect the player field
	var playerField = get_tree().get_nodes_in_group("PlayerField")
	for place in playerField:
		if place.is_connected("fieldSelect",playerPlaced):
			place.disconnect("fieldSelect",playerPlaced)
