extends Node3D


#	here are all the functions to calculate the damage

func executeAction(casue, target,action):
	print("battlestep")
	pass
	
func damageCalculation(damage):
	pass
#	if ship_current_shield > 0:
#		if damage > ship_current_shield:
#			damage = damage - ship_current_shield
#			ship_current_shield = 0
#			take_damage(damage)
#		else:
#			ship_current_shield = ship_current_shield - damage
#	elif ship_current_armor > 0:
#		if damage > ship_current_armor * 2:
#			damage = damage - ship_current_armor * 2
#			ship_current_armor = 0
#			take_damage(damage)
#		else:
#			ship_current_armor = ship_current_armor - round(damage / 2)
#	elif ship_current_health > 0:
#		if damage > ship_current_health:
#			damage = damage - ship_current_health
#			ship_current_health = 0
#		else:
#			ship_current_health = ship_current_health - damage
#	
#	$ShipUI.setStats(self.ship_name,self.ship_current_health, self.ship_health, self.ship_current_armor, self.ship_armor,self.ship_current_shield, self.ship_shield)
