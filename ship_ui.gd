extends Node3D

@export var healthObj : MeshInstance3D
@export var armorObj : MeshInstance3D
@export var shieldObj : MeshInstance3D

func _ready():
	add_to_group("ShipUI")

# cALLS  setStats but gets the values from parent
func updateShipUI():
	var ship = get_parent()
	setStats(ship.ship_name,ship.ship_current_health, ship.ship_health, ship.ship_current_armor, ship.ship_armor,ship.ship_current_shield, ship.ship_shield)

func setStats(name,health,maxHealth,armor,maxArmor,shield,maxShield):
	setShipName(name)
	setShipHealth(health, maxHealth)
	setShipArmor(armor,maxArmor)
	setShipShield(shield,maxShield)
	#print("set Stats")

func setShipName(name):
	print("text name: ", name)
	$Stats/Name.text = name
	$Stats/Name.modulate = Color("gray")

func setShipHealth(health,maxHealth):
	healthObj.scale.z = getRelativeStats(health,maxHealth)
	$Stats/Health.text = str(health) + " / " + str(maxHealth)
	$Stats/Health.modulate = Color("red")
	
func setShipArmor(armor,maxArmor):
	armorObj.scale.z = getRelativeStats(armor,maxArmor)
	$Stats/Armor.text = str(armor) + " / " + str(maxArmor)
	$Stats/Armor.modulate = Color("yellow") 

func setShipShield(shield,maxShield):
	shieldObj.scale.z = getRelativeStats(shield,maxShield)
	$Stats/Shield.text = str(shield) + " / " + str(maxShield)
	$Stats/Shield.modulate = Color("blue")

func getRelativeStats(current, max)->float:
	print("testtesttest Update SHIPUI ",current ," ",max)
	if max > 0:
		print("testtesttest Update SHIPUI ",current ," ",max, " ", current / float(max))
		return float(current) / float(max)
	return 0


	
