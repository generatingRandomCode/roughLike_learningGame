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
		
func displayStats(label):
	var stats = "Healt: {0} / {1} \nArmor: {2} / {3}\nShield {}"
	get_node("beschreibung").text = stats
