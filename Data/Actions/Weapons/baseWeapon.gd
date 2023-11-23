extends baseAction


class_name BaseWepon
#	The base Class from which all weapon classes inherit
#	 all the common functions are here

#	Must be the same as the filename

@export var wepon_damage: int

func executeDamageAction(target):
	damageCalculation(target, self.wepon_damage)

func damageCalculation(target, damage):
	#	because template is equiped
	if target.ship_current_shield > 0:
		await shildDamage(target, damage)
	elif target.ship_current_armor > 0:
		await armorDamage(target, damage)
	else:
		await healthDamage(target, damage)

func armorDamage(target, damage):
	if target.ship_current_armor > 0:
		if damage > target.ship_current_armor * 2:
			damage = damage - target.ship_current_armor * 2
			target.ship_current_armor = 0
			damageCalculation(target,damage)
		else:
			target.ship_current_armor = target.ship_current_armor - round(damage / 2)

func shildDamage(target, damage):
	if target.ship_current_shield > 0:
		if damage >= target.ship_current_shield:
			damage = damage - target.ship_current_shield
			target.ship_current_shield = 0
			#	hide the shield when shield is zero
			if target.has_node("Shield"):
				target.get_node("Shield").hide()
			damageCalculation(target,damage)
		else:
			target.ship_current_shield = target.ship_current_shield - damage

func healthDamage(target, damage):
	target.ship_current_health = max(0,target.ship_current_health - damage)

