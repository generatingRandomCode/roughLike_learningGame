extends Node

class_name baseAction

enum TargetPreselectionPatterns{
	Enemy = 0,
	Self = 1,
	FreeSpace = 2,
	Player = 3,
	FreeSpaceWithDistance = 4,
	FirstShipsInEachRow = 5,
	FirstInRow = 6,
	None = 7,
	}
enum ActionType {Action = 0, BonusAction = 1}

@export var energyCost : int
#	wepons can becom inactive through ammonitiondepeltions for expample
@export var active : bool = true
@export var icon : CompressedTexture2D
@export var wepon_name: String
@export var wepon_initiative: int
@export var needTarget :bool = false
#	true if need target field 
@export var needTargetField :bool = false
#	what nodes are in the target group
@export var targetPreselection : TargetPreselectionPatterns
#	function that defines what the wepond does
var description : String
var actionType : ActionType

#	get the stats from the player menu
@onready var main = get_tree().get_current_scene()
#	has to be here for the target stuff...
@onready var gridX = main.gridX
@onready var gridY = main.gridY

func _enter_tree():
	buildDescription()

#	function that shoud be called form outside the class if you want to execute a action
#	this shoud be in the action validation and not here
func action(action : Node) ->  void:
	#	check if you can pay the energy cost, if not pass or play animation
	await loadedAction(action)
	#if energyCost == 0:
	#	await loadedAction(action)
	#elif self.owner.useEnergy(energyCost):
	#	await loadedAction(action)
	#else:
	#	pass

#	function that every ACTION defines for itself
func loadedAction(action)-> void:
	pass
	
func getTargetGroupFromPre()-> Array:
	var targetGroup = self.targetPreselection
	return getTargetGroup(targetGroup)

func getTargetGroup(targetGroup : TargetPreselectionPatterns)-> Array:
	match(targetGroup):
		#	all enenmy
		TargetPreselectionPatterns.Enemy:
			if self.owner.is_in_group("player"):
				return get_tree().get_nodes_in_group("enemy").map(func(x): return x.get_parent())
			else:
				return get_tree().get_nodes_in_group("player").map(func(x): return x.get_parent())
		#	self
		TargetPreselectionPatterns.Self:
			return [self.owner.get_parent()]
		#	get the free player board
		TargetPreselectionPatterns.FreeSpace:
			if self.owner.is_in_group("player"):
				return get_tree().get_nodes_in_group("PlayerField").filter(func(a): return !a.has_node("Model"))
			else:
				return get_tree().get_nodes_in_group("EnemyField").filter(func(a): return !a.has_node("Model"))
		#	get all the player fields
		TargetPreselectionPatterns.Player:
			if self.owner.is_in_group("player"):
				return get_tree().get_nodes_in_group("player").map(func(x): return x.get_parent())
			else:
				return get_tree().get_nodes_in_group("enemy").map(func(x): return x.get_parent())
		TargetPreselectionPatterns.FreeSpaceWithDistance:
			return getTargetGroupForDistance(self.moveDistance)
		TargetPreselectionPatterns.FirstShipsInEachRow:
			return 	getFirstTargetinEachRow()
		TargetPreselectionPatterns.FirstInRow:
			return 	getFirstInRow()
		TargetPreselectionPatterns.None:
			return 	[]
		_:
			return []

#	returns last node in grid if empty
func getFirstInRow()->Array[Node]:
	var enemyField : Array
	if self.owner.is_in_group("player"):
		enemyField = get_tree().get_nodes_in_group("enemy").map(func(x)->Node: return x.get_parent()) 
	else:
		enemyField = get_tree().get_nodes_in_group("player").map(func(x)->Node: return x.get_parent())
	var nodeArray : Array[Node] = []
	var shipField = owner.get_parent()
	var yPos = int(str(shipField.name))
	#	get the last field in the same row as the player in case no ship is in row
	var last : Array[Node] 
	if self.owner.is_in_group("player"):
		last = get_tree().get_nodes_in_group("EnemyField").filter(
			func(x):return (x.get_parent().name == str(gridX-1)) and (x.name ==str(yPos)))
	else:
		last = get_tree().get_nodes_in_group("PlayerField").filter(
			func(x):return (x.get_parent().name == str(gridX-1)) and (x.name ==str(yPos)))
	#	variable for shor time storage
	var store
	for place in enemyField:
		if int(str(place.name)) == yPos:
			if store:
				if int(str(place.get_parent().name)) < int(str(store.get_parent().name)):
					store = place
			else:
				store=place
	if store:
		nodeArray += [store]
	else:
		nodeArray = last
			
	
	return nodeArray
#	get the first target in each row
func getFirstTargetinEachRow()->Array[Node]:
	var enemyField : Array
	if self.owner.is_in_group("player"):
		enemyField = get_tree().get_nodes_in_group("enemy").map(func(x): return x.get_parent())
	else:
		enemyField = get_tree().get_nodes_in_group("player").map(func(x): return x.get_parent())
	var nodeArray : Array[Node] = []
	for x in gridY:
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
	var playerField : Array
	if self.owner.is_in_group("player"):
		playerField = get_tree().get_nodes_in_group("PlayerField")
	else:
		playerField = get_tree().get_nodes_in_group("EnemyField")
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
	if get("usages"):
		self.description += "usages: " + str(self.usages) + "\n"

func hasEnoughEnergy()->bool:
	if energyCost == 0:
		return true
	if get_parent().ship_current_energy >= self.energyCost:
		return true
	return false
	
func getActionType():
	pass
