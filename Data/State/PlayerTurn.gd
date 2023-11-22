extends State

class_name PlayerTurnState

var actionsLeft
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
func selectAction(actionName):
	self.actionName = actionName
	await state_machine.transition_to("PlayerTurnState/ChooseTargetState",{
		})


func selectTarget(targetID):
	#	after last round 
	if self.actions:
		self.actions += [[actionName,selectedShipID,targetID]]
	else:
		self.actions = [[actionName,selectedShipID,targetID]]
		
	actionsLeft.erase(instance_from_id(selectedShipID))
	if(actionsLeft.size() > 0):
		await state_machine.transition_to("PlayerTurnState/ChoosePlayerState",{"Actions" : self.actions})
		selectedShipID = null
		actionName = null
	else:
		await state_machine.transition_to("EnemyState",{"Actions" = self.actions})
		selectedShipID = ""
		self.actions = []


