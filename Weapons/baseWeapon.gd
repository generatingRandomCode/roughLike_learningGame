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

func executeAction(target):
	damageCalculation(target, self.wepon_damage)

func damageCalculation(targetID, damage):
	#	because template is equiped
	var target = instance_from_id(targetID)
	if target.ship_current_shield > 0:
		await shildDamage(targetID, damage)
	elif target.ship_current_armor > 0:
		await armorDamage(targetID, damage)
	else:
		await healthDamage(targetID, damage)

func armorDamage(targetID, damage):
	var target = instance_from_id(targetID)
	if target.ship_current_armor > 0:
		if damage > target.ship_current_armor * 2:
			damage = damage - target.ship_current_armor * 2
			target.ship_current_armor = 0
			damageCalculation(targetID,damage)
		else:
			target.ship_current_armor = target.ship_current_armor - round(damage / 2)

func shildDamage(targetID, damage):
	var target = instance_from_id(targetID)
	if target.ship_current_shield > 0:
		if damage >= target.ship_current_shield:
			damage = damage - target.ship_current_shield
			target.ship_current_shield = 0
			#	hide the shield when shield is zero
			if target.has_node("Shield"):
				target.get_node("Shield").hide()
			damageCalculation(targetID,damage)
		else:
			target.ship_current_shield = target.ship_current_shield - damage

func healthDamage(targetID, damage):
	var target = instance_from_id(targetID)
	target.ship_current_health = max(0,target.ship_current_health - damage)

