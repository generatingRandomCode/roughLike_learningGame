extends Node3D

@export var healthObj : MeshInstance3D
@export var armorObj : MeshInstance3D
@export var shieldObj : MeshInstance3D

@export var enegyOff : StandardMaterial3D
@export var enegyOn : StandardMaterial3D

func _ready():
	add_to_group("ShipUI")
	if get_parent():
		updateShipUI()

# cALLS  setStats but gets the values from parent
func updateShipUI():
	var ship = get_parent()
	setStats(ship.ship_name,ship.ship_current_health, ship.ship_health, ship.ship_current_armor, ship.ship_armor,ship.ship_current_shield, ship.ship_shield,ship.ship_current_energy, ship.ship_energy)

func setStats(name,health,maxHealth,armor,maxArmor,shield,maxShield,energy,maxEnergy):
	setShipName(name)
	setShipHealth(health, maxHealth)
	setShipArmor(armor,maxArmor)
	setShipShield(shield,maxShield)
	setEnergy(energy,maxEnergy)
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
	if max > 0:
		return float(current) / float(max)
	return 0

func setEnergy(current,max):
	var startPosition = Vector3(-1,10,0)
	for x in min(12,max):
		var bubble = $ParameterUiErnergy.duplicate()
		bubble.show()
		bubble.position = startPosition
		
		if x < current:
			bubble.material_override = enegyOn
		else:
			bubble.material_override = enegyOff
		add_child(bubble)
		if (x + 1) % 6 == 0:
			startPosition = startPosition + Vector3(+6,-1,0)
		startPosition = startPosition + Vector3(-1,0,0)


func _process(delta):
	# Get the global position of the camera
	#var camera_global_transform = get_viewport().get_camera_3d().get_global_transform()
	#var camera_position = camera_global_transform.origin
	# Look at the camera
	#look_at(camera_position, Vector3(0, 1, 0))  # Adjust the up vector as needed
	pass
