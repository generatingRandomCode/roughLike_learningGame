extends Node

#	the base layout of a Action, each actions consist of a
#	-cause::Node
#	-action::Node	the emitting wepon node

#	if the acton needs a target it has a fuction to ceck for
class_name ActionTemplate

#	the  
var action : Node
var cause : Node
var causeField : Node
var targets : Node
var targetField : Node

var actionInitiative : int

var needTarget : bool = false
var needTargetField : bool = false
var energyCost : int

#	enum
var targetPreselection

#	gets called when calling new	get the id of both 
func getActionFromID(actionID: int) -> void:
	getActionFromObj(instance_from_id(actionID))


func getActionFromObj(action: Node) -> void:
	self.action = action
	self.targetPreselection = self.action.targetPreselection
	self.actionInitiative = self.action.wepon_initiative
	self.needTarget = self.action.needTarget
	self.needTargetField = self.action.needTargetField
	self.energyCost = self.action.energyCost
	#	should allways applay at the moment
	if self.action.owner:
		self.cause = self.action.owner
		self.causeField = self.cause.owner


func setTargets(targetIDs) -> void:
	setTargetsObj(instance_from_id(targetIDs))

func setTargetsObj(targetsOBJ) -> void:
	self.targets = targetsOBJ
	self.targetField = self.targets.get_parent()
	
func executeAction() -> void:
	await action.action(self)
	
func getTargetGroup()-> Array:
	return self.action.getTargetGroupFromPre()

func setTargetsFromFieldID(fieldID):
	self.targetField = instance_from_id(fieldID)
	print("field test: set field", targetField)
	if targetField.has_node("Model"):
		self.targets = targetField.get_node("Model")

func setTargetsFromFieldOBJ(field):
	self.targetField = field
	if targetField.has_node("Model"):
		self.targets = field.get_node("Model")

func hasEnoughEnergy()->bool:
	if cause.ship_current_energy >= action.energyCost:
		return true
	return false
	
func getActionShipEnergy()->int:
	return self.cause.ship_energy
	
func payActionShipEnergy()->void:
	action.cause.ship_current_energy = max(0, action.cause.ship_energy - self.energyCost)
