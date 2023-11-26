extends baseAction

class_name Shield

func _ready():
	needTarget = false

func selfShieldRaise(action : ActionTemplate ,raise : int):
	var ship = action.cause
	ship.ship_current_shield = min(ship.ship_current_shield + raise, ship.ship_shield)
	if ship.has_node("Shield"):
		ship.get_node("Shield").show()
