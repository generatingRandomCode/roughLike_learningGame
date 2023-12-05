extends Control

var button = preload("res://simpleButton.tscn")

@onready var gridX : LineEdit = $GetXY/GridX 
@onready var gridY : LineEdit = $GetXY/GridY
@onready var main = get_tree().get_root().get_node("main")


func _enter_tree():
	$GetXY.hide()
	$ChooseShip.hide()
	$ChooseShipNumber.hide()
#	for each ship in type a button will be created. yo

func _ready():
	main = get_tree().get_root().get_node("main")
	gridX.connect("text_submitted", main.get_node("StateMashine/ChooseBoardSizeState").chooseXGrid)
	gridY.connect("text_submitted", main.get_node("StateMashine/ChooseBoardSizeState").chooseYGrid)
	
	createNumberButton()
	var main = get_tree().get_root().get_node("main")
	var path = "res://Ships"	
	var dir = DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		var fileName = dir.get_next()
		while fileName != "":
			if dir.current_is_dir():
				continue
			else:
				createButton(fileName)
			fileName = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
	#	create number fields

func createButton(filename):
	var main = get_tree().get_root().get_node("main")
	filename = filename.split(".")[0]
	var buttonInstance = button.instantiate()
	
	buttonInstance.name = filename
	buttonInstance.text= filename
	#	get the ship icon
	var shipPath = "res://Ships/" + filename + ".tscn"
	var ship = load(shipPath)
	var shipInstance = ship.instantiate()
	if shipInstance.icon:
		buttonInstance.icon = shipInstance.icon
	shipInstance.queue_free()
	#
	$ChooseShip/startPanel/HBoxContainer.add_child(buttonInstance)
	#	connect to create game stat startProcess methode
	#	must be refactoring, no upwardds connectiong!
	buttonInstance.connect("start_pressed", main.get_node("StateMashine/ChooseShipToPlace").startPressed)

func createNumberButton():
	var main = get_tree().get_root().get_node("main")
	var number = 10
	for x in range(1,number):
		var buttonInstance = button.instantiate()
		buttonInstance.name = str(x)
		buttonInstance.text= str(x)
		$ChooseShipNumber/HBoxContainer.add_child(buttonInstance)
		buttonInstance.connect("start_pressed", main.get_node("StateMashine/ChooseShipNumberState").startPressed)
		
func getNumber():
	pass

