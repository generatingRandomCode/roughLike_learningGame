extends Node3D

var ship1 = preload("res://test_ship_01.tscn")

signal start_pressed

func _on_button_pressed():
	print("start pressed")
	start_pressed.emit()
