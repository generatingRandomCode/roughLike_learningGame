extends State

var button = preload("res://simpleButton.tscn")

var playerShips
var SelectedShip
var buttonInstance
#var playerField
# Called when the node enters the scene tree for the first time.
func _ready():
	main.get_node("ActionUI").hide()

func enter(parameter := {}) -> void:
	#SelectedShip = null
	#if SelectedShip != null:
		
	#playerField = main.get_node("PlayerGrid/Player")
	print("choose Action State")
	playerShips = get_tree().get_nodes_in_group("player")
	for x in playerShips:
		if x.get_child_count():
			if !x.get_node("Model").is_connected("shipClicked", showShipMenu):
				x.get_node("Model").connect("shipClicked" ,showShipMenu)
	
	#for place in playerField.get_children():
	#	place.connect("playerPlaced", playerPlaced)
	#$ActionUI.show()

#	get signal when on a ship from the player is clicked
func showShipMenu(nodeID):
		print("show shipMenu")
		if SelectedShip != nodeID:
			buildActionUI(nodeID)
			SelectedShip = nodeID
		#if !main.get_node("ActionUI").visible:
		main.get_node("ActionUI").show()
		main.get_node("ActionUI/ActionContainer").show()

#	add buttons with ship specific actions
func buildActionUI(shipID):
	var ship = instance_from_id(shipID)
	for wepon in ship.wepons:
		createActionButton(wepon)
	
#	creates the button
func createActionButton(wepon):
	buttonInstance = button.instantiate()
	buttonInstance.text = wepon.wepon_name
	buttonInstance.name = wepon.wepon_name
	main.get_node("ActionUI/ActionContainer").add_child(buttonInstance)
	#	connect the signal
	buttonInstance.connect("start_pressed", actionPress)
	
func actionPress(nodeID):
	print(instance_from_id(nodeID).name)
	print("actionPress ", nodeID)
	#	disconnect the ship node to make them non clickable
	for x in playerShips:
		x.get_node("Model").disconnect("shipClicked",showShipMenu)
	
	#buttonInstance.disconnect("start_pressed",actionPress)
	
	get_parent().transition_to("ChooseTargetState",{
		"ActionName" : instance_from_id(nodeID).name,
		"ActionCause" :  SelectedShip
		})
	
	

