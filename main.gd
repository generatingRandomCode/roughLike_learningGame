extends Node3D

var ship1 = preload("res://test_ship_01.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	
	print("start pressed")
	
	$Menu.hide()
	init_player()
	init_enemy()


func init_player():
	print("init_player")
	var instance = ship1.instantiate()
	instance.set_position(instance.get_position() + Vector3(-20, 0,0))
	instance.set("ship_name", "player") 
	instance.set_name("ship_player")
	instance.set("ship_name", "player")
	add_child(instance)
	#self.get_node("ship_player").set("ship_name", "player")
	
func init_enemy():
	var instance = ship1.instantiate()
	instance.set_position(instance.get_position() + Vector3(+20, 0,0))
	instance.set_name("ship_enemy")
	instance.set("ship_name", "enemy")
	add_child(instance)
