extends PlayerTurnState

signal actionSelected

#	connect the signal when the action is pressed
func _ready():
	connect("actionSelected", get_parent().selectAction)

func enter(parameter = {}) -> void:
	#actionChoosen
	selectedShip = parameter["selectedShip"]
	#	add bonus actions later
	#	hier werden all vom schiff ausführabren actionen hinzugefügt
	#	einfach eine weiterer Node3D hinzufügen als standardaction
	#	nur die arrays werden angezeigt die noch 
	var actionNameList : Array[Node] = []
	if selectedShip in get_parent().actionsLeft:
		actionNameList += selectedShip.actions
	if selectedShip in get_parent().bonusActionsLeft:
		actionNameList += selectedShip.bonusActions
	
	setAtionType(actionNameList)
	print("bonusAction",actionNameList)
	print("bonusAction", actionNameList[0].actionType)

	main.get_node("ActionUI").show()
	main.get_node("ActionUI").updateActions(actionNameList)
	main.get_node("ActionUI").connect("actionChoosen",actionChoosen)
	#main.get_node("ActionUI").connect("skipAction",skipAction)

func actionChoosen(shipAction : Node3D):
	if !shipAction.hasEnoughEnergy():
		return
	if !shipAction.active:
		return
	#	check if ship still can execute bonus action
	#if checkForBonusAction(shipAction):
	#	if shipAction not in selectedShip.bonusActions:
	#		return
	#else:
	#	if shipAction not in selectedShip.actions:
	#		return
	#	emit siggnal if ship still can execute the action
	actionSelected.emit(shipAction)

func exit()->void:
	main.get_node("ActionUI").hide()
	main.get_node("ActionUI").disconnect("actionChoosen",actionChoosen)

func setAtionType(actions: Array[Node]):
	for x in actions:
		print("debug: ", x.wepon_name)
		if x in selectedShip.actions:
			x.actionType = 0#	Action in enum
		else:
			x.actionType = 1#	BonusAction in enum

#	on all inputs
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_RIGHT:
			if event.pressed:
				if state_machine.state == self:
					#	bakc to player selection
					await state_machine.transition_to("PlayerTurnState/ChoosePlayerState")
