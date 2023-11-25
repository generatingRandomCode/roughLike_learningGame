extends baseAction

@export var usages : int = 2

func action(action : Node):
	if usages:
		action.targets.ship_current_armor = min(action.targets.ship_armor,action.targets.ship_current_armor + 100)
		usages -= 1
	if usages == 0:
		active = false

