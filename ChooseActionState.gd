extends State

var button = preload("res://simpleButton.tscn")

var playerShips
#var playerField
# Called when the node enters the scene tree for the first time.
func _ready():
	$ActionUI.hide()
	pass # Replace with function body.

func enter(parameter := {}) -> void:
	#playerField = main.get_node("PlayerGrid/Player")
	print("choose Action State")
	playerShips = get_tree().get_nodes_in_group("player")
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
		print(playerShips)
		buildActionUI(nodeName)
		if !$ActionUI.visible:
			$ActionUI.show()

#	add buttons with ship specific actions
func buildActionUI(shipID):
	var ship = instance_from_id(shipID)
	for wepon in ship.wepons:
		createActionButton(wepon)
func createActionButton(wepon):
	var buttonInstace = button.instantiate()
	buttonInstace.text = wepon.wepon_name
	$ActionUI/ActionContainer.add_child(buttonInstace)
