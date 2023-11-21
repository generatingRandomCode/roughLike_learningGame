extends State

#var button = preload("res://simpleButton.tscn")

var playerShips

#var playerField
# Called when the node enters the scene tree for the first time.
func _ready():
	main.get_node("ActionUI").hide()

func enter(parameter := {}) -> void:
	print("enter choose Player State")
	playerShips = get_tree().get_nodes_in_group("player")
	for x in playerShips:
		if x.get_child_count():
			if !x.is_connected("shipClicked", showShipMenu):
				x.connect("shipClicked" ,showShipMenu)

#	transition to the ship is clicked on
func showShipMenu(_nodeID):
	#	disconnect beforetransition
	for x in playerShips:
		x.disconnect("shipClicked",showShipMenu)
		
	get_parent().transition_to("ChooseActionState",{"SelectedShipID" :  _nodeID})

	

