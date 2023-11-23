extends PlayerTurnState


signal actionSelected


#	connect the signal when the action is pressed
func _ready():
	connect("actionSelected", get_parent().selectAction)

func enter(parameter = {}) -> void:
	#actionChoosen
	selectedShip = parameter["selectedShip"]
	#	add bonus actions later
	var actionNameList = selectedShip.actions#.map(func(x): return x.wepon_name)
	#buildActionUI(selectedShip)
	main.get_node("ActionUI").show()
	print("ACTIONUI: list ",actionNameList)
	main.get_node("ActionUI").updateActions(actionNameList)
	#get_tree().call_group("ActionUI", "updateActions", actionNameList)
	main.get_node("ActionUI").connect("actionChoosen",actionChoosen)


	

	
func actionChoosen(nodeID):
	main.get_node("ActionUI").disconnect("actionChoosen",actionChoosen)
	actionSelected.emit(nodeID)

func exit():
	main.get_node("ActionUI").hide()

