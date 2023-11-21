extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	#	hide ui
	$Action.hide()
	$Damage.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

#	getter ans setter for the ship ui NO handling logic

func setDamageDispaly():
	pass
	
func setStats(name,health,maxHealth,armor,maxArmor,shield,maxShield):
	setShipName(name)
	setShipHealth(health, maxHealth)
	setShipArmor(armor,maxArmor)
	setShipShield(shield,maxShield)
	print("set Stats")

func setShipName(name):
	print("text name: ", name)
	$Stats/Name.text = name
	$Stats/Name.modulate = Color("gray")

func setShipHealth(health,maxHealth):
	$Stats/Health.text = str(health) + " / " + str(maxHealth)
	$Stats/Health.modulate = Color("red")
	
func setShipArmor(armor,maxArmor):
	$Stats/Armor.text = str(armor) + " / " + str(maxArmor)
	$Stats/Armor.modulate = Color("yellow") 

func setShipShield(shield,maxShield):
	$Stats/Shield.text = str(shield) + " / " + str(maxShield)
	$Stats/Shield.modulate = Color("blue")
	


func _on_attack_pressed():
	pass # Replace with function body.
