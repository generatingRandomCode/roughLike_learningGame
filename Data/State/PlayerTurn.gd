extends State

class_name PlayerTurnState

#var actions

func enter(parameter := {}) -> void:
	print("Enter PlayerTurnState")
	var actions = []
	if parameter.has("Actions"):
		actions = parameter["Actions"]
	await get_parent().transition_to("PlayerTurnState/ChoosePlayerState",{"Actions" = actions})
	#ChoosePlayerState	
