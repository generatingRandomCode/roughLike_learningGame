extends State

var actionName
var actionCause
var enemyShips

var icon = preload("res://Data/3DVisual/3DAttackSelector.tscn")
#	State to enter when choosing an action for a ship
func enter(parameter := {}) -> void:
	actionName = parameter["ActionName"] 
	actionCause = parameter["ActionCause"] 
	main.get_node("ActionUI/ActionContainer").hide()
	main.get_node("ActionUI/Info").text = "Choose Target to shoot with " + actionName + "!"
	main.get_node("ActionUI/Info").show()
		#connect to all enemy ships
	enemyShips = get_tree().get_nodes_in_group("enemy")
	displayTargetIcon()
	for x in enemyShips:
		if x.get_child_count():
			if !x.is_connected("shipClicked" ,targetShip):
				#	die ui zum klicken sitzt auf modell, das muss ich mal ändern damit ich die schiffe besser bauen kann
				x.connect("shipClicked" ,targetShip)
	
func targetShip(shipID):
	print("targetShip")
	#	als action class die classe an sich übergeben
	for x in enemyShips: 
		x.disconnect("shipClicked",targetShip)
	get_parent().transition_to("ActionState",{
		"ActionName" : actionName,
		"ActionCause" :  actionCause,
		"ActionTarget" : shipID
		})

#	Ziel symbole, später abhängig davon 
func displayTargetIcon():
	var iconInstance = icon.instantiate()
	for x in enemyShips:
		if x.get_child_count():
			x.add_child(iconInstance)
