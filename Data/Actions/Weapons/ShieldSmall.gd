extends Shield
class_name ShieldSmall


func _ready():
	print("Shield Small")
	wepon_name = "ShieldSmall"
	#wepon_initiative = 1
	#wepon_damage = 0

func action(action) -> void:
	selfShieldRaise(150)
	#executeDamageAction(targetID)

