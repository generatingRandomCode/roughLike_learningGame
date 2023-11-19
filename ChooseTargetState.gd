extends State

var actionName
var actionCause
#	State to enter when choosing an action for a ship
func enter(parameter := {}) -> void:
	actionName = parameter["ActionName"] 
	actionCause = parameter["ActionCause"] 
	main.get_node("ActionUI/ActionContainer").hide()
	main.get_node("ActionUI/Info").text = "Choose Target to shoot with " + actionName + "!"
	main.get_node("ActionUI/Info").show()
	print("choose Target State")
	print("choose Target State: ", actionName)
		#connect to all enemy ships
	var enemyShips = get_tree().get_nodes_in_group("enemy")
	for x in enemyShips:
		if x.get_child_count():
			print("ship names; ", x.get_node("Model").name)
			#	die ui zum klicken sitzt auf modell, das muss ich mal ändern damit ich die schiffe besser bauen kann
			x.get_node("Model").connect("shipClicked" ,targetShip)
	
func targetShip(shipID):
	print("targetShip")
	#	als action class die classe an sich übergeben 
	get_parent().transition_to("ActionState",{
		"ActionName" : actionName,
		"ActionCause" :  actionCause,
		"ActionTarget" : shipID
		})
