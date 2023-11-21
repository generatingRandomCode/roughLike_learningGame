extends PlayerTurnState



#var playerField
# Called when the node enters the scene tree for the first time.


var actions

signal shipSelected

func _ready():
	connect("shipSelected", get_parent().selectPlayer)


func enter(parameter := {}) -> void:
	print("enter choose Player State")
	
	if parameter.has("Actions"):
		actions = parameter["Actions"]
		
	#	get the action array
	actionsLeft = get_parent().actionsLeft
	for x in actionsLeft:
		if !x:
			continue
		if x.get_child_count():
			if !x.is_connected("shipClicked", showShipMenu):
				x.connect("shipClicked" ,showShipMenu)
	print("enter choose Player Ende")
	
#	transition to the ship is clicked on
func showShipMenu(_nodeID):
	#	disconnect beforetransition

	for x in actionsLeft:
		if !x:
			continue
		if x.is_connected("shipClicked",showShipMenu):
			x.disconnect("shipClicked",showShipMenu)

	print("Actions array: ", actions)
	shipSelected.emit(actions, _nodeID)
	actions = {}

	

