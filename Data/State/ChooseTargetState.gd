extends PlayerTurnState


var icon = preload("res://Data/3DVisual/3DAttackSelector.tscn")
var targetGroup : Array[Node]

signal targetSelected

func _ready():
	connect("targetSelected", get_parent().selectTarget)

#	State to enter when choosing an action for a ship
func enter(parameter := {}) -> void:
	var targetPreselection = get_parent().actions[-1].targetPreselection
	print("targetPreselection: ", targetPreselection)
	
	targetGroup = getTargetGroup(targetPreselection)
	
	#	exit the target state if no target
	if !targetGroup:
		get_parent().startLoop()
		
		
	await displayTargetIcon()
	for x in targetGroup:
		if x.get_child_count():
			if !x.is_connected("shipClicked" ,targetShip):
				#	die ui zum klicken sitzt auf modell, das muss ich mal ändern damit ich die schiffe besser bauen kann
				x.connect("shipClicked" ,targetShip)
	
func getTargetGroup(targetPreselection)-> Array[Node]:
	match(targetPreselection):
		#	all enenmy
		0:
			return get_tree().get_nodes_in_group("enemy")
		#	self
		1:
			return get_parent().actions.cause
		#	get the free player board
		2:
			return get_tree().get_nodes_in_group("PlayerField").filter(
				func(a): return !a.has_node("Model")
			)
		_:
			return []
			
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
		x.disconnect("shipClicked",targetShip)
	freeTargetIcon()
	print("Actions array: target", actions)
	targetSelected.emit(targetID)

func exit():
	main.get_node("ActionUI").hide()
