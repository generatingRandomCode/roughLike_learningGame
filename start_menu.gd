extends Control

var button = preload("res://simpleButton.tscn")


#	for each ship in type a button will be created. yo
func _enter_tree():
	$ChooseShip.hide()
	$ChooseShipNumber.hide()
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

func createButton(fileName):
	var main = get_tree().get_root().get_node("main")
	fileName = fileName.split(".")[0]
	var buttonInstance = button.instantiate()
	buttonInstance.name = fileName
	buttonInstance.text= fileName
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
		buttonInstance.connect("start_pressed", main.get_node("StateMashine/GameStart").startPressed)
		
func getNumber():
	pass
