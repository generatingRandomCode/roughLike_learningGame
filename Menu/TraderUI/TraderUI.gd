extends Control

@onready var main : Node = get_tree().get_root().get_node("main") 
# Called when the node enters the scene tree for the first time.
signal endTrade

func _ready():
	hide()

func setMoney():
	$Control/Guthaben.text = str(main.playerMoney)

func endClicked():
	endTrade.emit()
