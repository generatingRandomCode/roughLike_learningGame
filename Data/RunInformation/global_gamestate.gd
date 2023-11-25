extends Node3D

#	this document stores the run specific information for the player, like what are the settings, what is the tile size,
#	
var gridX : int
var gridY : int


func _enter_tree():
	gridX = 3
	gridY = 3
