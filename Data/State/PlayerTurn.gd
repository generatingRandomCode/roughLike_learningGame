extends State

class_name PlayerTurnState

#	cannot have a exit function , it will break the loop which is bad...
#	all the player nodes with a ship
var actionsLeft
var bonusActionsLeft

#@export var skipAllButton : Button
var actions : Array[Node] = []
var action : Node
#	the selected ship model from the selected field
var selectedShip

func _ready():
	# connect the skip button
	timelineUI.connect("skipAll",skipAllAction)
	#skipAllButton.connect("pressed",skipAllAction)
	#	connect the skip action
	main.get_node("ActionUI").connect("skipAction",skipAction)

func enter(parameter := {}) -> void:
	#	init the standard actions for each ship actions:
	#	if entered from outside the playerturn
	#if parameter.has("Actions"):
	self.actions = parameter["Actions"]
	print("new Actions: start", actions)
	if !actionsLeft:
		actionsLeft = get_tree().get_nodes_in_group("player")
	
	if !bonusActionsLeft:
		bonusActionsLeft = get_tree().get_nodes_in_group("player")
	
	#	choose player for action
	await get_parent().transition_to("PlayerTurnState/ChoosePlayerState")
	#	show skip all button at the end ?



#	get the causeID and opens the action board for the ship where is checked what actions the ship can execute
func selectPlayer(selectedFieldID):
	selectedShip = instance_from_id(selectedFieldID).get_node("Model")
	await state_machine.transition_to("PlayerTurnState/ChooseActionState",{"selectedShip" :  selectedShip})


#	get the ship action
func selectAction(shipAction):
	self.action = shipAction
	var newAction = ActionTemplate.new()
	newAction.getActionFromObj(shipAction)
	self.actions += [newAction]
	if action.needTarget or action.needTargetField:
		await state_machine.transition_to("PlayerTurnState/ChooseTargetState")
	else:
		checkForActionsLeft()

#	get the target id for the action
func selectTarget(targetID):
	actions[-1].setTargetsFromFieldID(targetID)
	checkForActionsLeft()

func checkForActionsLeft():
	removeUsedAction(action)
	#	when skip signal is clicked
	print("bonusAction: ", actionsLeft, bonusActionsLeft)
	#	delete the ship the action was choosen for and the specific action (bonus or standard)
	#	abfrage für sofort action
	
	if(actionsLeft + bonusActionsLeft):
		await state_machine.transition_to("PlayerTurnState/ChoosePlayerState")
	else:
		print("new Actions: ", actions)
		await state_machine.transition_to("ActionState",{"Actions" = self.actions})
	#	clear
	
	selectedShip = null
	action = null

func skipAction():
	actionsLeft.erase(selectedShip)
	bonusActionsLeft.erase(selectedShip)
	checkForActionsLeft()
	
func skipAllAction():
	#	only allow skip when we are in one of the player states
	if (state_machine.state != self) and (state_machine.state not in get_children()):
		return
	#only deactivate as clickable when there are no actions to click left
	if actionsLeft + bonusActionsLeft:
		actionsLeft = []
		bonusActionsLeft = []
		checkForActionsLeft()

func removeUsedAction(action : Node)->void:
	if !action:
		return
	if checkForBonusAction(action):		
		bonusActionsLeft.erase(selectedShip)
	else:
		actionsLeft.erase(selectedShip)
	
#	returns true when the action is a bonus action and false when it is a normal action
func checkForBonusAction(shipAction):
	if shipAction in selectedShip.bonusActions:
		return true
	if shipAction in selectedShip.actions:
		return false
