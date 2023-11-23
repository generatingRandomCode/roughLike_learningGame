extends Node3D

#Init the board

var base = preload("res://player_grid_base.tscn")

# Called when the node enters the scene tree for the first time.
#	distance between x is the distance between start
func _ready():
	base = base.instantiate()
	initBoardPlayer(base,"player",-20,-20, 30)
	initBoardPlayer2(base,"Enemy",20,-20, 30)
	removeClickZones("Enemy")

#	z von unten nach oben |
#	x rechts nach links
func initBoardPlayer(grid,player,offsetX,offsetZ, space):
	var safeZ = offsetZ
	for x in range(3):
		for z in range(3):
			#to dont double the ships
			var newGrid = grid.duplicate()
			newGrid.set_position(Vector3(offsetX, 0,offsetZ))
			#rotate to face inwards
			newGrid.rotate(Vector3(0,1,0), PI*1.5)
			newGrid.add_to_group("PlayerField")
			$Player.add_child(newGrid)
			offsetZ = offsetZ + space
		offsetX += -space
		offsetZ = safeZ
	
func initBoardPlayer2(grid,player,offsetX,offsetZ,space):
	
	for x in range(3):
		for z in range(3):
			#to dont double the ships
			var newGrid = grid.duplicate()
			newGrid.set_position(Vector3(offsetX, 0,offsetZ))
			#rotate to face inwards
			newGrid.rotate(Vector3(0,1,0), PI*0.5)
			newGrid.add_to_group("EnemyField")
			$Enemy.add_child(newGrid)
			offsetZ = offsetZ +space
		offsetX +=  space
		offsetZ = -20
		
func removeClickZones(fieldName):
	var player2Root = get_node(fieldName)
	for sub in player2Root.get_children():
		#sub.get_node("Area3D").queue_free()
		#	to click on zone later again
		#if sub.has_node("Area3D"):
		#	sub.get_node("Area3D").hide()
		if sub.has_node("Ship"):
			sub.get_node("Ship").queue_free()
		

