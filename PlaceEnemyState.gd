extends State

var shipTemplate = preload("res://test_ship_01.tscn")
var enemyGrid
var main

func enter(_msg := {}) -> void:
	main = get_tree().get_root().get_node("main")
	enemyGrid = get_tree().get_root().get_node("main/PlayerGrid/Player2")
	#enemyGrid = get_tree().get_node("Player2")
	print("place Enemy State")
	placeEnemy()
	
func placeEnemy():
	# Get a random index to select a random child
	var random_index = randi() % enemyGrid.get_child_count()
	# Create a new node as a child
	var shipInstance = shipTemplate.instantiate()
	shipInstance.build("Typ1")
	# Add the new node as a child to the random child
	enemyGrid.get_child(random_index).add_child(shipInstance)
	print("Added a new node to a random child.")
