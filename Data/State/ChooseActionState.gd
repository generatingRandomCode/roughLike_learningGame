extends PlayerTurnState

var button = preload("res://simpleButton.tscn")
var buttonInstance

signal actionSelected

#	connect the signal when the action is pressed
func _ready():
	connect("actionSelected", get_parent().selectAction)

func enter(parameter = {}) -> void:
	#	clear the ui

	selectedShipID = parameter["SelectedShipID"]
	buildActionUI(selectedShipID)
	main.get_node("ActionUI").show()
	main.get_node("ActionUI/ActionContainer").show()

#	add buttons with ship specific actions
func buildActionUI(shipID):
	var ship = instance_from_id(shipID)
	for wepon in ship.actions:
		createActionButton(wepon)
	
#	creates the button
func createActionButton(wepon):
	buttonInstance = button.instantiate()
	buttonInstance.text = wepon.wepon_name
	buttonInstance.name = str(wepon.get_instance_id())
	main.get_node("ActionUI/ActionContainer").add_child(buttonInstance)
	#	connect the signal
	buttonInstance.connect("start_pressed", actionPress)
	
func actionPress(nodeID):
	#	the node name is the id of the action
	nodeID = instance_from_id(nodeID).name
	actionSelected.emit(nodeID)

func exit():
	main.get_node("ActionUI/ActionContainer").hide()
	main.get_node("ActionUI").hide()
	for x in main.get_node("ActionUI/ActionContainer").get_children():
		main.get_node("ActionUI/ActionContainer").remove_child(x)
		x.queue_free()
