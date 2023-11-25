extends Node3D


#@export_file  var globalGameState

#	stores all the game imporand files

signal start_pressed


var gridX : int
var gridY : int


func _enter_tree():
	gridX = 4
	gridY = 4

