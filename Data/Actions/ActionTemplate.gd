extends Node

#	the base layout of a Action, each actions consist of a
#	-cause::Node
#	-action::Node	the emitting wepon node

#	if the acton needs a target it has a fuction to ceck for
class_name ActionTemplate

#	the  
var action
var cause
var causeField
var targets
var targetField


var actionInitiative

var needTarget = 0

var targetPreselection

#	gets called when calling new	get the id of both 
func getActionFromID(actionID) -> void:
	if typeof(actionID) == TYPE_INT:
		self.action = instance_from_id(actionID)
	else:
		self.action = instance_from_id(int(str(actionID)))

	self.targetPreselection = self.action.targetPreselection
	self.actionInitiative = self.action.wepon_initiative
	self.needTarget = self.action.needTarget
	
	if self.action.get_parent():
		self.cause = self.action.get_parent()
		self.causeField = self.cause.get_parent()

func getActionFromObj(action: Node) -> void:
	self.action = action
	self.targetPreselection = self.action.targetPreselection
	self.actionInitiative = self.action.wepon_initiative
	self.needTarget = self.action.needTarget
	
	if self.action.get_parent():
		self.cause = self.action.get_parent()
		self.causeField = self.cause.get_parent()


func setTargets(targetIDs) -> void:
	self.targets = instance_from_id(targetIDs)

func setTargetsObj(targetsOBJ) -> void:
	self.targets = targetsOBJ
	self.targetField = self.targets.get_parent()
	
func executeAction() -> void:
	action.action(self)
	
func getTargetGroup()-> Array:
	return self.action.getTargetGroup()

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
