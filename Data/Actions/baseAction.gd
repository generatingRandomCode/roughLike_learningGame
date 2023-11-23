extends Node

class_name baseAction

enum TargetPreselectionPatterns{Enemy = 0, Self = 1, FreeSpace = 2}

@export var wepon_name: String
@export var wepon_initiative: int
@export var needTarget :bool = false
#	what nodes are in the target group
@export var targetPreselection : TargetPreselectionPatterns
#	function that defines what the wepond does
func action(action) ->  void:
	pass

