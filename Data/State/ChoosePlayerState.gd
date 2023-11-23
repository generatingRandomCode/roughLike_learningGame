extends PlayerTurnState

signal shipSelected

func _ready():
	connect("shipSelected", get_parent().selectPlayer)

#	all the fields with player action
var playerFields

func enter(parameter := {}) -> void:
	print("enter choose Player State")
	playerFields = get_parent().actionsLeft.map(func(x): return x.get_parent())
		
	#	get the action array
	displayPlayerIcon()
	for x in playerFields:
		if !x:
			continue
		if x.get_child_count():
			if !x.is_connected("fieldSelect", showShipMenu):
				x.connect("fieldSelect" ,showShipMenu)
	print("enter choose Player Ende")
	
#	transition to the field is clicked on
func showShipMenu(_nodeID):
	
	shipSelected.emit( _nodeID)

func displayPlayerIcon():
	for x in playerFields:
		x.get_node("FieldSelect").show()

func freePlayerIcon():
	for x in playerFields:
		x.get_node("FieldSelect").hide()
	
func exit():
	freePlayerIcon()
	for x in playerFields:
		if !x:
			continue
		if x.is_connected("fieldSelect",showShipMenu):
			x.disconnect("fieldSelect",showShipMenu)
