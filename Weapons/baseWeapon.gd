extends Node


class_name BaseWepon
#	The base Class from which all weapon classes inherit
#	 all the common functions are here

#	Must be the same as the filename
@export var wepon_name: String
@export var wepon_initiative: int
@export var wepon_damage: int

#	function that defines what the wepond does
func action():
	pass
