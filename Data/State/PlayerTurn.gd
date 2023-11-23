extends State

class_name PlayerTurnState

var actionsLeft
var bonusActionsLeft
var actionName

#func _ready():

var actions
var selectedShipID
#var actionsLeft

func enter(parameter := {}) -> void:
	if !actionsLeft:
		actionsLeft = get_tree().get_nodes_in_group("player")
	
	print("Enter PlayerTurnState")
	
	await get_parent().transition_to("PlayerTurnState/ChoosePlayerState")
	
	
func selectPlayer(selectedShipID):
	self.selectedShipID = selectedShipID
	await state_machine.transition_to("PlayerTurnState/ChooseActionState",{
		"SelectedShipID" :  selectedShipID,
	})

#	hier wird aufgerufen was bei der jeweiligen action pssieren soll
func selectAction(actionID):
	#actionName = instance_from_id(actionName)
	if self.actions:
		self.actions += [ActionTemplate.new(actionID,selectedShipID)]
	else:
		self.actions = [ActionTemplate.new(actionID,selectedShipID)]

	#self.actionName = actionName.name
	print("ActionTemplate array", actions)
	if actions[-1].needTarget:
		await state_machine.transition_to("PlayerTurnState/ChooseTargetState")
	else:
		startLoop()
	


func selectTarget(targetID):
	actions[-1].setTargets(targetID)
	startLoop()
	#	after last round 
	#if self.actions:
	#	self.actions += [[actionName,selectedShipID,targetID]]
	#else:
	#	self.actions = [[actionName,selectedShipID,targetID]]
		
	

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
	
