extends PlayerTurnState


var icon = preload("res://Data/3DVisual/3DAttackSelector.tscn")
var targetGroup : Array

signal targetSelected

func _ready():
	connect("targetSelected", get_parent().selectTarget)

#	State to enter when choosing an action for a ship
func enter(parameter := {}) -> void:
	targetGroup = get_parent().actions[-1].getTargetGroup()
	#	exit the target state if no target
	if !targetGroup:
		get_parent().startLoop()
		
	await displayTargetIcon()
	for x in targetGroup:
		if x.get_child_count():
			if !x.is_connected("fieldSelect" ,targetShip):
				#	die ui zum klicken sitzt auf modell, das muss ich mal ändern damit ich die schiffe besser bauen kann
				x.connect("fieldSelect" ,targetShip)
	

#	Ziel symbole, später abhängig davon 
func displayTargetIcon():

	for x in targetGroup:
		if !x.has_node("AttackSelection"):
			var iconInstance = icon.instantiate()
			x.add_child(iconInstance)

func freeTargetIcon():

	for x in targetGroup:
		if x.has_node("AttackSelection"):
			x.get_node("AttackSelection").queue_free()
	
func targetShip(targetID):
	for x in targetGroup: 
		x.disconnect("fieldSelect",targetShip)
	freeTargetIcon()
	print("Actions array: target", actions)
	targetSelected.emit(targetID)

func exit():
	main.get_node("ActionUI").hide()
