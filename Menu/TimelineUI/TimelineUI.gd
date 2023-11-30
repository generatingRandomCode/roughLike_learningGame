extends Control

signal skipAll

func _ready():
	hide()

func displayTurn(turn : String):
	var turnDispaly = $Control/TextureRect/roundCounter/Value
	turnDispaly.text = turn
	show()


func _on_next_round_pressed():
	skipAll.emit()
