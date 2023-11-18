extends State



# Called when the node enters the scene tree for the first time.
func _ready():
	$ActionUI.hide()
	pass # Replace with function body.

func enter(parameter := {}) -> void:
	print("choose Action State")
	var playerShips = get_tree().get_nodes_in_group("player")
	for x in playerShips:
		if x.get_child_count():
			print("ship names; ", x.get_node("Model").name)
			x.get_node("Model").connect("shipClicked" ,showShipMenu)
	
	#for place in playerField.get_children():
	#	place.connect("playerPlaced", playerPlaced)
	#$ActionUI.show()

#	get signal when on a ship from the player is clicked
func showShipMenu(nodeName):
		print("showShipMenu")
		if !$ActionUI.visible:
			$ActionUI.show()
