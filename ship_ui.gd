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

func setShipHealth(health,maxHealth):
	healthObj.scale.z = getRelativeStats(health,maxHealth)
	
func setShipArmor(armor,maxArmor):
	armorObj.scale.z = getRelativeStats(armor,maxArmor)

func setShipShield(shield,maxShield):
	shieldObj.scale.z = getRelativeStats(shield,maxShield)

func getRelativeStats(current, max)->float:
	print("testtesttest Update SHIPUI ",current ," ",max)
	if max > 0:
		print("testtesttest Update SHIPUI ",current ," ",max, " ", current / float(max))
		return float(current) / float(max)
	return 0

func _process(delta):
	# Get the global position of the camera
	#var camera_global_transform = get_viewport().get_camera_3d().get_global_transform()
	#var camera_position = camera_global_transform.origin
	# Look at the camera
	#look_at(camera_position, Vector3(0, 1, 0))  # Adjust the up vector as needed
	pass
