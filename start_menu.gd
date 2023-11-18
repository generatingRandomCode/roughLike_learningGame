extends Control

var button = preload("res://simpleButton.tscn")
var main


#	for each ship in type a button will be created. yo
func _ready():
	main = get_tree().get_root().get_node("main")
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

func createButton(fileName):
	fileName = fileName.split(".")[0]
	var buttonInstance = button.instantiate()
	buttonInstance.name = fileName
	buttonInstance.text= fileName
	#buttonInstance.pressed.connect(self._on_button_pressed)
	$ChoseShip/startPanel/HBoxContainer.add_child(buttonInstance)
	print("FileName: ", fileName)
	print("startMenu: ",$ChoseShip/startPanel/HBoxContainer.get_children())
	print("startMenu: ",$ChoseShip/startPanel/HBoxContainer.name)
	#	connect to create game stat startProcess methode
	buttonInstance.connect("start_pressed", main.get_node("StateMashine/GameStart").startPressed)


