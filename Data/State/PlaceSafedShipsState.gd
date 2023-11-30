extends State

#var base = preload("res://player_grid_base.tscn")
var playerGrid = preload("res://player_grid.tscn")

#this class gets the safed ships and lets you replace them
func enter(parameter = {}):
	
	if !main.has_node("PlayerGrid"):
		#	place a new player grid
		var playerGridInstance = playerGrid.instantiate()
		main.add_child(playerGridInstance)
		#	remove the exmapel ship from the grid
		playerGridInstance.removeClickZones("PlayerField")
		
	#main.playerShips
	#if main.get_node("SafePlayerShips").get_child_count():
	var savedShips = main.get_node("SafePlayerShips").get_children()
	print("shippath", savedShips)
	print("shippath", main.playerShips)
	print("shippath", main.get_node("PlayerGrid"))
	for x in main.get_node("SafePlayerShips").get_child_count():
		var ship = savedShips[x]
		var shipPath = main.playerShips[x]
		ship.get_parent().remove_child(ship)
		get_node(shipPath).add_child(ship)
		ship.name = "Model" 
		pass
	print("shippath", main.get_node("PlayerGrid"))
	
	get_parent().transition_to("PlaceEnemyState")

