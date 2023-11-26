extends Node3D


#@export_file  var globalGameState

#	stores all the game imporand files

signal start_pressed

var gamestart : bool = true
var gridX : int
var gridY : int
#var playerShipsNames : Array[String]
var currentLevelCount : int = 0
var playerShips : Array = []
var currentCampaign : Campaign
var currentLevel : BaseLevel
var playerMoney : int = 0



func _enter_tree():
	gridX = 3
	gridY = 3

