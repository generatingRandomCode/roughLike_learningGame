extends Node

#	the base layout of a Action, each actions consist of a
#	-cause::Node
#	-action::Node	the emitting wepon node

#	if the acton needs a target it has a fuction to ceck for
class_name ActionTemplate

#	the  
var cause
#	the action class
var action

var targets

var actionInitiative

var needTarget = 0

#	gets called when calling new	get the id of both 
func _init(actionID, causeID, targetID = null):
	self.cause = instance_from_id(causeID)
	#self.action = self.cause.get_node(str(instance_from_id(actionID).name))
	self.action = instance_from_id(int(str(actionID)))
	if targetID:
		self.targets = instance_from_id(targetID)
	self.actionInitiative = self.action.wepon_initiative
	self.needTarget = self.action.needTarget
	
	print("ActionTemplate cause ", self.cause)
	print("ActionTemplate action ", self.action)
	print("ActionTemplate actionInitiative ", self.actionInitiative)
	print("ActionTemplate needTarget ", self.needTarget)
	

func setTargets(targets):
	self.targets = instance_from_id(targets)

func executeAction():
	action.action(self)
