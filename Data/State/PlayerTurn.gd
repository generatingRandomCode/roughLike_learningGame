extends State

class_name PlayerTurnState

var actionsLeft
var bonusActionsLeft
var actionName

var actions
var selectedShipID

func enter(parameter := {}) -> void:
	#	if entered from outside the playerturn
	if !actionsLeft:
		actionsLeft = get_tree().get_nodes_in_group("player")
	#	choose player for action
	await get_parent().transition_to("PlayerTurnState/ChoosePlayerState")

#	get the causeID and opens the action board for the ship where is checked what actions the ship can execute
func selectPlayer(selectedShipID):
	self.selectedShipID = selectedShipID
	await state_machine.transition_to("PlayerTurnState/ChooseActionState",{"SelectedShipID" :  selectedShipID,})

#	hier wird aufgerufen was bei der jeweiligen gewählten action pssieren soll
func selectAction(actionID):
	#actionName = instance_from_id(actionName)
	if self.actions:
		self.actions += [ActionTemplate.new(actionID,selectedShipID)]
	else:
		self.actions = [ActionTemplate.new(actionID,selectedShipID)]
		
	print("ActionTemplate array", actions)
	if actions[-1].needTarget:
		await state_machine.transition_to("PlayerTurnState/ChooseTargetState")
	else:
		startLoop()

#	get the target id for the action
func selectTarget(targetID):
	actions[-1].setTargets(targetID)
	startLoop()

func startLoop():
	actionsLeft.erase(instance_from_id(selectedShipID))
	if(actionsLeft.size() > 0):
		await state_machine.transition_to("PlayerTurnState/ChoosePlayerState",{"Actions" : self.actions})
		selectedShipID = null
		actionName = null
	else:
		await state_machine.transition_to("EnemyState",{"Actions" = self.actions})
		selectedShipID = ""
		self.actions = []
