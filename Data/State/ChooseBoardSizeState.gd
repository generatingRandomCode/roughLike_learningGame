extends State

var gridX : int
var gridY : int

#	here the info for how to size the player will be extracted

#	for debuging i will deactivat
func enter(_msg := {}) -> void:
	main.get_node("StartMenu").show()
	main.get_node("StartMenu/GetXY").show()
	print("test")
	#deactivate
	gridX = 2
	gridY = 2
	valuesChosen()
	

func chooseXGrid(gridX : String):
	self.gridX = convertToCoor(gridX)
	valuesChosen()

	
func chooseYGrid(gridY : String):
	self.gridY = convertToCoor(gridY)
	valuesChosen()
func convertToCoor(number: String)->int:
	return min(max(1,abs(int(number))),10)

func valuesChosen():
	
	if gridX and gridY:
		main.gridX = gridX
		main.gridY = gridY
		main.get_node("StartMenu").hide()
		main.get_node("StartMenu/GetXY").hide()
		get_parent().transition_to("ChooseShipNumberState")



