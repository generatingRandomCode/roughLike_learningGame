extends Node3D

var isEmpty = true
var shipTemplate = preload("res://test_ship_01.tscn")
# Called when the node enters the scene tree for the first time.
func _ready(): # Replace with function body.
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_3d_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton:
		if(isEmpty):
			if event.button_index == MOUSE_BUTTON_LEFT and event.pressed == true:
				isEmpty = false;
				init_ship("enemy", 200, 50 , 75, 20)
				


func init_ship(name,health,armor,shield,x):
	var rng = RandomNumberGenerator.new()
	print("init_",name)
	var instance = shipTemplate.instantiate()
	#instance.set_position(instance.get_position() + Vector3(x, 0,0))
	#instance.set("ship_name", "player") 
	instance.build(name,health,armor,shield)
	instance.set_name(name)
	var randomX = rng.randf_range(-90, 90)
	var randomY = rng.randf_range(-90, 90)
	var randomZ = rng.randf_range(-90, 90)
	instance.set_rotation(Vector3(randomX,randomY,randomZ))
	add_child(instance)
