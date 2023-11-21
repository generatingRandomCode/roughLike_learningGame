extends State

class_name PlayerTurnState

var actionsLeft
#var actions
#func _ready():

#var actionsLeft

func enter(parameter := {}) -> void:
	if !actionsLeft:
		actionsLeft = get_tree().get_nodes_in_group("player")
	
	var actions = []
	print("Enter PlayerTurnState")
	if parameter.has("Actions"):
		actions = parameter["Actions"]
	await get_parent().transition_to("PlayerTurnState/ChoosePlayerState",{"Actions" = actions})
	
	
func selectPlayer(actions,selectedShipID):
	await state_machine.transition_to("PlayerTurnState/ChooseActionState",{
		"SelectedShipID" :  selectedShipID,
		"Actions" : actions
		
	})

func selectAction(actions,selectedShipID,actionID):
	
	await state_machine.transition_to("PlayerTurnState/ChooseTargetState",{
		"ActionName" : instance_from_id(actionID).name,
		"ActionCause" :  selectedShipID,
		"Actions"	: actions
		})
		
func selectTarget(actions):
	pass

