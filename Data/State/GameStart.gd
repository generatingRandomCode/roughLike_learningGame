extends State

#	This state handles the start menu and the player placement 
#	this function is called when the state is entered
#	show the menu


#	get the number of player ships
func enter(_msg := {}) -> void:
	get_parent().transition_to("ChooseBoardSizeState")
