extends State


#	called at the start of combat and at start of each round
func enter(parameter := {}) -> void:
	await updateShips()
	get_parent().transition_to("PlayerTurnState",{})


func updateShips():
	get_tree().call_group("Ship", "updateEnergy")
	get_tree().call_group("ShipUI", "updateShipUI")
	#updateEnergy
