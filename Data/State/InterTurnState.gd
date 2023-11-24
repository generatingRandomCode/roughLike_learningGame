extends State


#	called at the start of combat and at start of each round
func enter(parameter := {}) -> void:
	await updateShips()
	get_parent().transition_to("PlayerTurnState",{})


func updateShips():
	#	update the ship energy
	get_tree().call_group("Ship", "updateEnergy")
	#	update the ship ui
	get_tree().call_group("ShipUI", "updateShipUI")
	#updateEnergy
