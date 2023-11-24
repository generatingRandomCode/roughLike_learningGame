extends State

class_name PlayerTurnState

#	all the player nodes with a ship
var actionsLeft
var bonusActionsLeft

var actions : Array[Node] = []
var action : Node
#	the selected ship model from the selected field
var selectedShip

func _ready():
	#	connect the skip action
	main.get_node("ActionUI").connect("skipAction",skipAction)

func enter(parameter := {}) -> void:
	#	init the standard actions for each ship actions:
	#	if entered from outside the playerturn
	if !actionsLeft:
		actionsLeft = get_tree().get_nodes_in_group("player")#.map(func(x): return x.get_parent())
	
	if !bonusActionsLeft:
		bonusActionsLeft = get_tree().get_nodes_in_group("player")#.map(func(x): return x.get_parent())
	#	choose player for action
	await get_parent().transition_to("PlayerTurnState/ChoosePlayerState")

#	get the causeID and opens the action board for the ship where is checked what actions the ship can execute
func selectPlayer(selectedFieldID):
	selectedShip = instance_from_id(selectedFieldID).get_node("Model")
	await state_machine.transition_to("PlayerTurnState/ChooseActionState",{"selectedShip" :  selectedShip})

#	hier wird aufgerufen was bei der jeweiligen gewählten action pssieren soll

func selectAction(shipAction):
	self.action = shipAction
	var newAction = ActionTemplate.new()
	newAction.getActionFromObj(shipAction)
	self.actions += [newAction]
	if actions[-1].needTarget:
		await state_machine.transition_to("PlayerTurnState/ChooseTargetState")
	else:
		startLoop()

#	get the target id for the action
func selectTarget(targetID):
	actions[-1].setTargetsFromFieldID(targetID)
	startLoop()

func startLoop():
	if checkForBonusAction(action):		
		bonusActionsLeft.erase(selectedShip)
	else:
		actionsLeft.erase(selectedShip)
	# call function to check the 
	#	when skip signal is clicked
	print("bonusAction: ", actionsLeft, bonusActionsLeft)
	#	delete the ship the action was choosen for and the specific action (bonus or standard)
	#	abfrage für sofort action
	
	if((actionsLeft.size() + bonusActionsLeft.size()) > 0):
		await state_machine.transition_to("PlayerTurnState/ChoosePlayerState",{"Actions" : self.actions})
	else:
		await state_machine.transition_to("EnemyState",{"Actions" = self.actions})
		self.actions = []
	#	clear
	
	selectedShip = null
	action = null

func skipAction():
	actionsLeft.erase(selectedShip)
	bonusActionsLeft.erase(selectedShip)
	startLoop()

#	returns true when the action is a bonus action and false when it is a normal action
func checkForBonusAction(shipAction):
	if shipAction in selectedShip.bonusActions:
		return true
	if shipAction in selectedShip.actions:
		return false
