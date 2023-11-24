extends State

class_name PlayerTurnState

#	all the player nodes with a ship
var actionsLeft
var bonusActionsLeft

var actions = []
#	the selected ship model from the selected field
var selectedShip

func enter(parameter := {}) -> void:
	#	init the standard actions for each ship actions:
	
	
	#	if entered from outside the playerturn
	if !actionsLeft:
		actionsLeft = get_tree().get_nodes_in_group("player")#.map(func(x): return x.get_parent())
	#	choose player for action
	await get_parent().transition_to("PlayerTurnState/ChoosePlayerState")

#	get the causeID and opens the action board for the ship where is checked what actions the ship can execute
func selectPlayer(selectedFieldID):
	selectedShip = instance_from_id(selectedFieldID).get_node("Model")
	await state_machine.transition_to("PlayerTurnState/ChooseActionState",{"selectedShip" :  selectedShip})

#	hier wird aufgerufen was bei der jeweiligen gewählten action pssieren soll

func selectAction(shipAction = null):
	#	when skip signal is clicked
	if !shipAction:
		startLoop()
		return

	var newAction=ActionTemplate.new()
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
	#	delete the ship the action was choosen for and the specific action (bonus or standard)
	actionsLeft.erase(selectedShip)
	#	abfrage für sofort action
	if(actionsLeft.size() > 0):
		await state_machine.transition_to("PlayerTurnState/ChoosePlayerState",{"Actions" : self.actions})
		selectedShip = null
	else:
		await state_machine.transition_to("EnemyState",{"Actions" = self.actions})
		selectedShip = null
		self.actions = []
