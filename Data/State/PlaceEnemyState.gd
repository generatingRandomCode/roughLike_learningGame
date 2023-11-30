extends State


#var enemyGrid


func enter(parameter := {}) -> void:
	var enemyGrid = get_tree().get_nodes_in_group("EnemyField")
	print("place Enemy State")
	placeEnemyFromCurrentLevel()
	#placeEnemyRandom()
	get_parent().transition_to("InterTurnState")


func placeEnemyFromCurrentLevel():
	var enemyGrid = get_tree().get_nodes_in_group("EnemyField")
	var currentLevel = main.currentLevel
	var enemyGridRoot = main.get_node("PlayerGrid/Enemy")
	for index in currentLevel.enemyShipsNames.size():
		var shipName = currentLevel.enemyShipsNames[index]
		var shipPath = "res://Ships/" + shipName + ".tscn"
		var ship = load(shipPath)
		var shipInstance = ship.instantiate()
		shipInstance.add_to_group("enemy")
		#var posX =  currentLevel.enemyPosition[index][0]
		#var posY =  currentLevel.enemyPosition[index][0]
		var random_index = randi() % enemyGrid.size()
		if !enemyGrid[random_index].has_node("Model"):
			enemyGrid[random_index].add_child(shipInstance)
		#	prevents enemy from spawning on top of each other
		enemyGrid.erase(enemyGrid[random_index])
		#enemyGridRoot.get_node(str(posX)).get_node(str(posY)).add_child(shipInstance)
		
	


func placeEnemyRandom():
	var enemyGrid = get_tree().get_nodes_in_group("EnemyField")
	var enemyNumber = max(1,randi() % 9)
	#var enemyNumber = 2
	var shipList = []
	var path = "res://Ships"	
	var dir = DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		var fileName = dir.get_next()
		while fileName != "":
			if dir.current_is_dir():
				continue
			else:
				shipList.append(fileName)
			fileName = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
	
	for x in range(enemyNumber):
		var randShip = randi() % shipList.size()
		var random_index = randi() % enemyGrid.size()
		if !enemyGrid[random_index].has_node("Model"):
			var shipPath = "res://Ships/" + shipList[randShip].split(".")[0] + ".tscn"
			var ship = load(shipPath)
			var shipInstance = ship.instantiate()
			# Get a random index to select a random child
			shipInstance.add_to_group("enemy")
			enemyGrid[random_index].add_child(shipInstance)
		# Create a new node as a child
		# Add the new node as a child to the random child
		print("Added a new EnemyShip to a random child.")
