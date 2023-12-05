extends Control

@onready var main : Node = get_tree().get_root().get_node("main") 
@onready var shipsDisplay = $Control/ShipsDisplay
@onready var shipsDisplayButton = $Control/ShipsDisplay/StandardShipButton
@onready var shipDir : DirAccess = DirAccess.open("res://Ships")
@export var audioButton: AudioStreamPlayer;

# Called when the node enters the scene tree for the first time.
signal endTrade

func _ready():
	hide()
	buildShipShop()

func setMoney():
	$Control/Guthaben.text = str(main.playerMoney)

func endClicked():
	audioButton.play()
	endTrade.emit()

func buildShipShop():
	if shipDir:
		shipDir.list_dir_begin()
		var fileName = shipDir.get_next()
		while fileName != "":
			if shipDir.current_is_dir():
				continue
			else:
				createShipBuyButton(fileName)
			fileName = shipDir.get_next()

func createShipBuyButton(filename):
	var newButton = shipsDisplayButton.duplicate()
	newButton.name = filename.split(".")[0]
	#	wie krieg ich das jeweilige icon hier her, ich muss das schiff bauen, ohne geht es nicht
	#	load the ship for the icon
	var shipPath = "res://Ships/" + filename
	var ship = load(shipPath)
	var shipInstance = ship.instantiate()
	if shipInstance.icon:
		newButton.get_node("Icon").texture = shipInstance.icon
	shipInstance.queue_free()
	shipsDisplay.add_child(newButton)
	newButton.show()
	#	button signal connect (function.bind(callable that will be returned))
	newButton.pressed.connect(shipButtonPressed.bind(newButton))

func shipButtonPressed(button):
	var shipName = button.name
	audioButton.play()
	#	if to littel money
	if main.playerMoney < 100:
		return
	#	pay 100
	main.playerMoney -= 100
	var shipPath = "res://Ships/" + shipName + ".tscn"
	var ship = load(shipPath)
	var shipInstance = ship.instantiate()
	#
	main.get_node("SafePlayerShips").add_child(shipInstance)
	shipInstance.add_to_group("player")
	shipInstance.name = "Model"
	#	add path to main
	main.playerShips += ["/root/main/PlayerGrid/Player/0/1"]
	#var testField = get_tree().get_nodes_in_group("Field")
	#testField[0].add_child(shipInstance)
	print("butoontest",button)
	setMoney()


