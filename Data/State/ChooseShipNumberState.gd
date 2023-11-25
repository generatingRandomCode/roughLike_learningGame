extends State

#	This state handles the start menu and the player placement 
#	this function is called when the state is entered
#	show the menu


#	get the number of player ships
func enter(_msg := {}) -> void:
	var number  = 0
	main.get_node("StartMenu").show()
	main.get_node("StartMenu/ChooseShipNumber").show()
	#main.get_node("StartMenu/ChooseShip").show()



func startPressed(numberID):
	var number =  instance_from_id(numberID)
	number = number.name
	main.get_node("StartMenu/ChooseShipNumber").hide()
	get_parent().transition_to("ChooseShipToPlace",{"Number": number})
