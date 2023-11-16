extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	var grid = $PlayerGridBase

	var y = 0
	var offsetX = 0
	var offsetZ = -20
	
	for x in range(3):
		
		for z in range(3):
			#to dont double the ships
			if (offsetZ != -20) or (offsetX != 0):
				var newGrid = grid.duplicate()
				newGrid.set_position(Vector3(offsetX, 0,offsetZ))
				add_child(newGrid)
			offsetZ = offsetZ +20
			
		offsetX += -20
		offsetZ = -20



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
