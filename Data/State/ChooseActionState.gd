extends PlayerTurnState

var button = preload("res://simpleButton.tscn")

var playerShips
var SelectedShipID
var buttonInstance
var actions
#var playerField
# Called when the node enters the scene tree for the first time.

func enter(parameter = {}) -> void:
	if parameter.has("Actions"):
		actions = parameter["Actions"]
		
	#	clear the ui
	for x in main.get_node("ActionUI/ActionContainer").get_children():
		main.get_node("ActionUI/ActionContainer").remove_child(x)
		x.queue_free()
	
	print("Enter choose Action State")
	SelectedShipID = parameter["SelectedShipID"] 
	#if SelectedShip != nodeID:
	buildActionUI(SelectedShipID)
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
	await state_machine.transition_to("PlayerTurnState/ChooseTargetState",{
		"ActionName" : instance_from_id(nodeID).name,
		"ActionCause" :  SelectedShipID,
		"Actions"	: actions
		})
	actions = {}
	
	

