extends State


var enemyGrid


func enter(parameter := {}) -> void:

	enemyGrid = get_tree().get_root().get_node("main/PlayerGrid/Enemy")
	#enemyGrid = get_tree().get_node("Player2")
	print("place Enemy State")
	placeEnemy()
	
func placeEnemy():
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
		var random_index = randi() % enemyGrid.get_child_count()
		if !enemyGrid.get_child(random_index).has_node("Model"):
			var shipPath = "res://Ships/" + shipList[randShip].split(".")[0] + ".tscn"
			var ship = load(shipPath)
			var shipInstance = ship.instantiate()
			# Get a random index to select a random child
			shipInstance.add_to_group("enemy")
			enemyGrid.get_child(random_index).add_child(shipInstance)
		# Create a new node as a child
		# Add the new node as a child to the random child
		print("Added a new EnemyShip to a random child.")
	
	get_parent().transition_to("InterTurnState")
