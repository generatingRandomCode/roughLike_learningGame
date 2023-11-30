extends Control


func displayTurn(turn : String):
	var turnDispaly = $Control/TextureRect/roundCounter/Value
	turnDispaly.text = turn
