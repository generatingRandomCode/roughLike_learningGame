extends Node

class_name baseAction

enum TargetPreselectionPatterns{Enemy = 0, Self = 1, FreeSpace = 2, Player = 3, FreeSpaceWithDistance = 4, FirstShips = 5}
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
		TargetPreselectionPatterns.FreeSpaceWithDistance:
			return getTargetGroupForDistance(self.moveDistance)
		TargetPreselectionPatterns.FirstShips:
			return 	getFirstTargetinEachRow()
		_:
			return []

#	get the first target in each row
func getFirstTargetinEachRow()->Array[Node]:
	var enemyField = get_tree().get_nodes_in_group("enemy").map(func(x): return x.get_parent())
	var nodeArray : Array[Node] = []
	var gridX = 3
	for x in gridX:
		var store
		for place in enemyField:
			if str(place.name) == str(x):
				if store:
					if int(str(place.get_parent().name)) < int(str(store.get_parent().name)):
						store = place
				else:
					store = place
		if store:
			nodeArray += [store]
			store = null
	#print("shipField x: ", nodeArray)
	return nodeArray

#	returns all free fieds in distance x from the cause
func getTargetGroupForDistance(distance : int)->Array[Node]:
	var nodeArray : Array[Node] = []
	var playerField = get_tree().get_nodes_in_group("PlayerField")
	var gridX = 3
	var gridY = 3
	var shipField = owner.get_parent()
	var xPos = int(str(shipField.get_parent().name))
	var yPos = int(str(shipField.name))
	for place in playerField:
		if place == shipField:
			continue
		var placeX = int(str(place.get_parent().name))
		var placeY = int(str(place.name))
		
		if abs(placeX - xPos) > distance:
			continue
		if abs(placeY - yPos) > distance:
			continue
		if place.has_node("Model"):
			continue
		nodeArray += [place]
	return nodeArray

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
