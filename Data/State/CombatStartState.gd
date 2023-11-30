extends State

func enter(parameter := {}) -> void:
	resetShipsAtCombatStart()
	get_parent().transition_to("InterTurnState")
	
	
func resetShipsAtCombatStart():
	for ship in get_tree().get_nodes_in_group("player"):
		ship.ship_current_energy = ship.ship_energy
