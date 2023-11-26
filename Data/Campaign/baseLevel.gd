extends Node

#	class to store and alter a single campaign level

class_name BaseLevel

	#	init the basic campaing data and store it somwhere
var gridX : int = 3
var gridY : int = 3
@export var  enemyShipsNames : Array[String]
#@export var enemyPosition : Array[int]	#	x,y
#@export var enemyShips : Array[Node3D]
@export var lootMoney : int

