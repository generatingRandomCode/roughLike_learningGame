extends Node

#	class to store and alter a single campaign level

class_name BaseLevel

	#	init the basic campaing data and store it somwhere
#	variable to decide what kind of level will be created
enum LevelTyps{
	Combat = 0,
	Trader = 1,
	}

@export var levelTyp : LevelTyps

var gridX : int = 3
var gridY : int = 3
@export var  enemyShipsNames : Array[String]

#@export var enemyPosition : Array[int]	#	x,y
#@export var enemyShips : Array[Node3D]
@export var lootMoney : int


func isCombatLevel():
	if self.levelTyp == LevelTyps.Combat:
		return true
	return false


