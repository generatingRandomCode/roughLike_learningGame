extends CharacterBody3D


#	This class hast all the basic functions to create a instance ship
class_name ShipTemplate

#	BASIC SHUP VALUES
var ship_name
var ship_health 
var ship_current_health 
var ship_armor 
var ship_current_armor 
var ship_shield 
var ship_current_shield

signal mouse_click
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

#	gets the 3Dlabel and sets the color and text of the ship stats
func update_dispaly():
	#	{0} ist placeholder a name is also allowd but must be kalled in a keyed array [test = "foo"]
	var display = "{0} / {1}"
	get_node("text/beschreibung").text = ship_name
	#	modulate is the color atribute
	get_node("text/beschreibung").modulate = Color("gray") 
	get_node("text/health").text = display.format([ship_current_health, ship_health])
	get_node("text/health").modulate = Color("red") 
	get_node("text/armor").text = display.format([ship_current_armor, ship_armor])
	get_node("text/armor").modulate = Color("yellow") 
	get_node("text/shield").text = display.format([ship_current_shield, ship_shield])
	get_node("text/shield").modulate = Color("blue") 
		

func damage_step(damage):
	$text/Action.hide()
	var oldH = self.ship_current_health
	var oldA = self.ship_current_armor
	var oldS = self.ship_current_shield
	take_damage(damage)
	
	displayDamage(oldH,oldA,oldS)
	
	
func displayDamage(health, armor, shield):
	var string = "healt damage: {0}, armordamage: {1}, shielddamage: {2}"
	health = max(0,health - self.ship_current_health)
	armor = max(0, armor - self.ship_current_armor)
	shield = max(0, shield- self.ship_current_shield)
	string = string.format([health,armor,shield])
	$damageText.show()
	$damageText/HBoxContainer/Label.text = string
	await mouse_click
	$damageText.hide()
	$text/Action.show()
	


func _input(event):
	if(Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and $damageText.visible):
		emit_signal("mouse_click")
		
#func _input(event):
#	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and $damageText.visible:
#		$damageText.hide()
#		$text/Action.show()
		
func take_damage(damage):
	
	if ship_current_shield > 0:
		if damage > ship_current_shield:
			damage = damage - ship_current_shield
			ship_current_shield = 0
			take_damage(damage)
		else:
			ship_current_shield = ship_current_shield - damage
	elif ship_current_armor > 0:
		if damage > ship_current_armor * 2:
			damage = damage - ship_current_armor * 2
			ship_current_armor = 0
			take_damage(damage)
		else:
			ship_current_armor = ship_current_armor - round(damage / 2)
	elif ship_current_health > 0:
		if damage > ship_current_health:
			damage = damage - ship_current_health
			ship_current_health = 0
		else:
			ship_current_health = ship_current_health - damage
	update_dispaly()
