extends PlayerTurnState

signal shipSelected

func _ready():
	connect("shipSelected", get_parent().selectPlayer)
#	all the fields with player action
var playerFields

var choosableFields

func enter(parameter := {}) -> void:
	var actionsField = get_parent().actionsLeft.map(func(x): return x.get_parent())
	var bonusActionsField = get_parent().bonusActionsLeft.map(func(x): return x.get_parent())
	playerFields = actionsField + bonusActionsField
	playerFields = delete_duplicates(playerFields)
	
	#	get the action array
	displayPlayerIcon()
	for x in playerFields:
		if !x:
			continue
		if x.get_child_count():
			if !x.is_connected("fieldSelect", showShipMenu):
				x.connect("fieldSelect" ,showShipMenu)

	
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

func delete_duplicates(array: Array):
	var result = []
	for i in range(array.size()):
		var duplicated = false
		for j in range(i+1, array.size()):
			if array[i] == array[j]:
				duplicated = true
				break
		if not duplicated:
			result += [array[i]]
	return result
