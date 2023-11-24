extends PlayerTurnState

signal actionSelected

#	connect the signal when the action is pressed
func _ready():
	connect("actionSelected", get_parent().selectAction)

func enter(parameter = {}) -> void:
	#actionChoosen
	selectedShip = parameter["selectedShip"]
	#	add bonus actions later
	#	hier werden all vom schiff ausführabren actionen hinzugefügt
	#	einfach eine weiterer Node3D hinzufügen als standardaction
	var actionNameList = selectedShip.actions
	main.get_node("ActionUI").show()
	main.get_node("ActionUI").updateActions(actionNameList)
	main.get_node("ActionUI").connect("actionChoosen",actionChoosen)
	#main.get_node("ActionUI").connect("skipAction",skipAction)

func actionChoosen(shipAction):

	if shipAction.hasEnoughEnergy():
		actionSelected.emit(shipAction)
		
#func skipAction():
		#actionSelected.emit()
	
	

func exit():
	main.get_node("ActionUI").hide()
	#main.get_node("ActionUI").disconnect("skipAction",skipAction)
	main.get_node("ActionUI").disconnect("actionChoosen",actionChoosen)

