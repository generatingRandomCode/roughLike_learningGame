extends PlayerTurnState

signal actionSelected

#	connect the signal when the action is pressed
func _ready():
	connect("actionSelected", get_parent().selectAction)

func enter(parameter = {}) -> void:
	#actionChoosen
	selectedShip = parameter["selectedShip"]
	#	add bonus actions later
	var actionNameList = selectedShip.actions
	main.get_node("ActionUI").show()
	main.get_node("ActionUI").updateActions(actionNameList)
	main.get_node("ActionUI").connect("actionChoosen",actionChoosen)

func actionChoosen(nodeID):
	var actionToTest = instance_from_id(nodeID)
	if actionToTest.hasEnoughEnergy():
		main.get_node("ActionUI").disconnect("actionChoosen",actionChoosen)
		actionSelected.emit(nodeID)



func exit():
	main.get_node("ActionUI").hide()

