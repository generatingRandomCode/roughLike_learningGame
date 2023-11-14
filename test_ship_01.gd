extends CharacterBody3D

const NAME = "test schiff"



var ship_health = 100
var ship_current_health = 100
var ship_armor = 100
var ship_current_armor = 100
var ship_shield = 100
var ship_current_shield = 100

	
#	This function is called when the collision box of the ship is clicked
#	see the ship struckture for refference how it is strucktured
func _on_area_3d_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed == true:
			#	debug message
			print("pressed left mouse button");
			ship_current_shield = max(0, ship_current_shield - 10)
			update_dispaly()
			
			
#	gets called when ship is init
func _enter_tree():	
	print("curren tree");
	update_dispaly()
	
#	gets the 3Dlabel and sets the color and text of the ship stats
func update_dispaly():
	#	{0} ist placeholder a name is also allowd but must be kalled in a keyed array [test = "foo"]
	var display = "{0} / {1}"
	get_node("text/beschreibung").text = NAME
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
	
	
	
