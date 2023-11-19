extends State

var shipTemplate = preload("res://test_ship_01.tscn")
var enemyGrid


func enter(parameter := {}) -> void:

	enemyGrid = get_tree().get_root().get_node("main/PlayerGrid/Player2")
	#enemyGrid = get_tree().get_node("Player2")
	print("place Enemy State")
	placeEnemy()
	
func placeEnemy():
	
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
		
	#print("fileNameName: ", shipList)
	#	choose a random ship to spwan
	var randShip = randi() % shipList.size()
	# Get a random index to select a random child
	var random_index = randi() % enemyGrid.get_child_count()
	# Create a new node as a child
	var shipInstance = shipTemplate.instantiate()
	shipInstance.add_to_group("enemy")
	
	shipInstance.build(shipList[randShip].split(".")[0])
	# Add the new node as a child to the random child
	enemyGrid.get_child(random_index).add_child(shipInstance)
	print("Added a new node to a random child.")
	
	get_parent().transition_to("ChooseActionState")
