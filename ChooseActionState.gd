extends State

var button = preload("res://simpleButton.tscn")

var playerShips
var SelectedShip
#var playerField
# Called when the node enters the scene tree for the first time.
func _ready():
	#main = get_tree().get_root().get_node("main")
	main.get_node("ActionUI").hide()
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
		if SelectedShip == nodeName:
			return
		SelectedShip = nodeName
		buildActionUI(nodeName)
		if !main.get_node("ActionUI").visible:
			main.get_node("ActionUI").show()

#	add buttons with ship specific actions
func buildActionUI(shipID):
	#for x in main.get_node("ActionUI/ActionContainer").get_children():
	#	x.queue_free()
	var ship = instance_from_id(shipID)
	for wepon in ship.wepons:
		createActionButton(wepon)
	
#	creates the button
func createActionButton(wepon):
	var buttonInstace = button.instantiate()
	buttonInstace.text = wepon.wepon_name
	main.get_node("ActionUI/ActionContainer").add_child(buttonInstace)
	#	connect the signal
