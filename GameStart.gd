extends State

var playerGrid = preload("res://player_grid.tscn")

var main
#	this function is called when the state is entered
func enter(_msg := {}) -> void:
	main = get_tree().get_root().get_node("main")
	print("main node:", main.name)
	for x in main.get_children():
		print(x.name)
	main.get_node("Menu").show()
	#main.Menu.show()
	print("gameStart")
	var EMITTER = get_parent().get_parent()
	#EMITTER.connect("start_pressed", self, "start_pressed")
	#	connect connect the node from whish it is called to a function in the node where the current script is
	EMITTER.connect("start_pressed", startPressed)


func startPressed():
	print("connected signal")
	$"../../Menu".hide()
	playerGrid = playerGrid.instantiate()
	main.add_child(playerGrid)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print("gameone")
	pass
