extends State

class_name PlayerTurnState

#	cannot have a exit function , it will break the loop which is bad...
#	all the player nodes with a ship
var actionsLeft
var bonusActionsLeft

@export var skipAllButton : Button
var actions : Array[Node] = []
var action : Node
#	the selected ship model from the selected field
var selectedShip

func _ready():
	#	connect the skip action
	main.get_node("ActionUI").connect("skipAction",skipAction)
	skipAllButton.connect("pressed",skipAllAction)
	skipAllButton.hide()

func enter(parameter := {}) -> void:
	#	init the standard actions for each ship actions:
	#	if entered from outside the playerturn
	if !actionsLeft:
		actionsLeft = get_tree().get_nodes_in_group("player")
	
	if !bonusActionsLeft:
		bonusActionsLeft = get_tree().get_nodes_in_group("player")
	
	skipAllButton.show()
	#	choose player for action
	await get_parent().transition_to("PlayerTurnState/ChoosePlayerState")



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
		await state_machine.transition_to("PlayerTurnState/ChoosePlayerState",{"Actions" : self.actions})
	else:
		await state_machine.transition_to("EnemyState",{"Actions" = self.actions})
		skipAllButton.hide()
		self.actions = []
	#	clear
	
	selectedShip = null
	action = null

func skipAction():
	actionsLeft.erase(selectedShip)
	bonusActionsLeft.erase(selectedShip)
	checkForActionsLeft()
	
func skipAllAction():
	skipAllButton.hide()
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
