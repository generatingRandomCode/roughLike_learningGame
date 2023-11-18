extends Node3D

var ship1 = preload("res://test_ship_01.tscn")

signal start_pressed
# Called when the node enters the scene tree for the first time.
func _ready():
	#$Menu.hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	#	initiates the  player
	#init_ship("player", 100, 100 , 100, -20)
	#init_ship("enemy", 200, 50 , 75, 20)
	print("start pressed")
	#
	start_pressed.emit()
	#$Menu.hide()

func init_ship(name,health,armor,shield,x):
	print("init_",name)
	var instance = ship1.instantiate()
	instance.set_position(instance.get_position() + Vector3(x, 0,0))
	#instance.set("ship_name", "player") 
	instance.build(name,health,armor,shield)
	instance.set_name(name)
	instance.rotate(Vector3(0,1,0), PI*1.5)
	add_child(instance)
	#self.get_node("ship_player").set("ship_name", "player")
