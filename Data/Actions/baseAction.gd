extends Node

class_name baseAction

enum TargetPreselectionPatterns{Enemy = 0, Self = 1, FreeSpace = 2, Player = 3}
enum ActionType {Action= 0, BonusAction=1}

@export var energyCost : int
@export var icon : CompressedTexture2D
@export var wepon_name: String
@export var wepon_initiative: int
@export var needTarget :bool = false
#	what nodes are in the target group
@export var targetPreselection : TargetPreselectionPatterns
#	function that defines what the wepond does
var description : String
var actionType : ActionType


func _enter_tree():
	buildDescription()

func action(action) ->  void:
	#	check if you can pay the energy cost, if not pass or play animation
	if energyCost == 0:
		loadedAction(action)
	elif get_parent().useEnergy(energyCost):
		loadedAction(action)
	else:
		pass
	
func loadedAction(action)-> void:
	pass

func getTargetGroup()-> Array:
	match(self.targetPreselection):
		#	all enenmy
		TargetPreselectionPatterns.Enemy:
			return get_tree().get_nodes_in_group("enemy").map(func(x): return x.get_parent())
		#	self
		TargetPreselectionPatterns.Self:
			return [get_parent().get_parent()]
		#	get the free player board
		TargetPreselectionPatterns.FreeSpace:
			return get_tree().get_nodes_in_group("PlayerField").filter(
				func(a): return !a.has_node("Model")
			)
		#	get all the player fields
		TargetPreselectionPatterns.Player:
			return get_tree().get_nodes_in_group("player").map(func(x): return x.get_parent())
		_:
			return []

func buildDescription():
	self.description = "wepon_initiative: " + str(self.wepon_initiative) + "\n"
	self.description = "energyCost: " + str(self.energyCost) + "\n"
	if get("wepon_damage"):
		self.description += "wepon_damage: " + str(self.wepon_damage) + "\n"

func hasEnoughEnergy()->bool:
	if energyCost == 0:
		return true
	if get_parent().ship_current_energy >= self.energyCost:
		return true
	return false
	
func getActionType():
	pass
