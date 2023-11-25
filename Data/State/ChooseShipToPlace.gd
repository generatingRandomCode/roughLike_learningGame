extends State

#	This state handles the start menu and the player placement 
#	this function is called when the state is entered
var number
#	show the menu and will be looped for the number of 
func enter(parameter := {}) -> void:
	if parameter.has("Number"):
		number = str(parameter["Number"]).to_int()
	print("number ",number)

	if number > 0:
		main.get_node("StartMenu").show()
		main.get_node("StartMenu/ChooseShip").show()
	else:
		#	when number reaches zero 
		main.get_node("PlayerGrid").removeClickZones("PlayerField")
		get_parent().transition_to("PlaceEnemyState")
	

#	load playerfield 
func startPressed(buttonID):
	number = number - 1
	main.get_node("StartMenu").hide()

	print("button Name: ",buttonID )
	var shipName = instance_from_id(buttonID)
	shipName = shipName.name
	get_parent().transition_to("PlacePlayerState",{"shipName" : shipName})
	

	
