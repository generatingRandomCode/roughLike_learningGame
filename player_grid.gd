extends Node3D

#Init the board

var base = preload("res://player_grid_base.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	base = base.instantiate()
	initBoardPlayer(base,"player",-10,-20)
	initBoardPlayer2(base,"player2",50,-20)
	removeEnemyClickZones()

	


func initBoardPlayer(grid,player,offsetX,offsetZ):
	var safeZ = offsetZ
	for x in range(3):
		
		for z in range(3):
			#to dont double the ships
			var newGrid = grid.duplicate()
			newGrid.set_position(Vector3(offsetX, 0,offsetZ))
			#rotate to face inwards
			newGrid.rotate(Vector3(0,1,0), PI*1.5)
			get_node("Player").add_child(newGrid)
			offsetZ = offsetZ +20
		offsetX += -20
		offsetZ = safeZ
	
func initBoardPlayer2(grid,player,offsetX,offsetZ):
	
	for x in range(3):
		
		for z in range(3):
			#to dont double the ships
			var newGrid = grid.duplicate()
			newGrid.set_position(Vector3(offsetX, 0,offsetZ))
			#rotate to face inwards
			#newGrid.rotate(Vector3(0,1,0), PI*0.5)
			newGrid.rotate(Vector3(0,1,0), PI*0.5)
			get_node("Player2").add_child(newGrid)
			offsetZ = offsetZ +20
		offsetX += -20
		offsetZ = -20
		
func removeEnemyClickZones():
	var player2Root = $Player2
	for sub in player2Root.get_children():
		#print("child_name: ",sub.name)
		sub.get_node("Area3D").queue_free()
		

