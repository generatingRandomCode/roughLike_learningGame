extends PlayerTurnState

var button = preload("res://simpleButton.tscn")

var playerShips
var selectedShipID
var buttonInstance
var actions

#var playerField
# Called when the node enters the scene tree for the first time.

signal actionSelected

func _ready():
	connect("actionSelected", get_parent().selectAction)

func enter(parameter = {}) -> void:
	if parameter.has("Actions"):
		actions = parameter["Actions"]
		
	#	clear the ui
	for x in main.get_node("ActionUI/ActionContainer").get_children():
		main.get_node("ActionUI/ActionContainer").remove_child(x)
		x.queue_free()
	
	print("Enter choose Action State")
	selectedShipID = parameter["SelectedShipID"] 
	#if SelectedShip != nodeID:
	buildActionUI(selectedShipID)
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
	main.get_node("ActionUI/ActionContainer").hide()
	#	why is text ok but name not?  text is ok but name is problematic when adding more buttons
	print("Actions array: Chooseactions", actions)
	actionSelected.emit(actions,selectedShipID,nodeID)
	actions = {}
	
	

