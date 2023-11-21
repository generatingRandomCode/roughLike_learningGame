extends State



#var playerField
# Called when the node enters the scene tree for the first time.

var actions

var actionsLeft

func _ready():
	
	
	main.get_node("ActionUI").hide()

func enter(parameter := {}) -> void:
	print("enter choose Player State")
	
	if parameter.has("Actions"):
		actions = parameter["Actions"]
	
		
	if !actionsLeft:
		actionsLeft = get_tree().get_nodes_in_group("player")
		print("showShipMenu:Zuweisung ", actionsLeft)
		
	#	get the action array
		
	for x in actionsLeft:
		if x.get_child_count():
			if !x.is_connected("shipClicked", showShipMenu):
				x.connect("shipClicked" ,showShipMenu)

#	transition to the ship is clicked on
func showShipMenu(_nodeID):
	#	disconnect beforetransition

	for x in actionsLeft:
		x.disconnect("shipClicked",showShipMenu)

	print("showShipMenu: ", actionsLeft)
	print("showShipMenu ",instance_from_id(_nodeID))
	actionsLeft.erase(instance_from_id(_nodeID))
	print("showShipMenu: ", actionsLeft)
	
	#if(actionsLeft)
	print("Actions array: ", actions)
	await get_parent().transition_to("ChooseActionState",{
		"SelectedShipID" :  _nodeID,
		"Actions" : actions
		
	})
	actions = {}

	

