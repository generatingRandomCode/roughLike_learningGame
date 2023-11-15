extends "res://shipTemplate.gd"





#	gets called when ship is init
func _ready():	
	print("_ready()");
	#ship_name = "test ship"
	ship_health = 100
	ship_current_health = 100
	ship_armor = 100
	ship_current_armor = 100
	ship_shield = 100
	ship_current_shield = 100
	#	init values from file in future
	#	update the stats
	update_dispaly()
	
#	This function is called when the collision box of the ship is clicked
#	see the ship struckture for refference how it is strucktured
func _on_area_3d_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed == true:
			#	debug message
			print("pressed left mouse button");
			ship_current_shield = max(0, ship_current_shield - 10)
			update_dispaly()


func _on_attack_pressed():
	var test = self.get_parent().get_node("ship_enemy").get("ship_current_shield")
	var enemy = self.get_parent().get_node("ship_enemy")
	enemy.take_damage(60)

	print("current shild: " , test)
