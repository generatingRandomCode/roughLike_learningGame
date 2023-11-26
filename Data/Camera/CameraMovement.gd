extends Node3D

@export var cam3D: Camera3D;
var moveDirection: Vector3;
@export var moveSpeed: float;


# Called when the node enters the scene tree for the first time.
func _ready():
	moveDirection = Vector3(0,0,0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position = Vector3(position.x+moveDirection.x*delta*moveSpeed, position.y+moveDirection.y*delta*moveSpeed, position.z+moveDirection.z*delta*moveSpeed)

func _input(event):
	if event.is_action_pressed("wheel_up"):
		wheelUp()
	if event.is_action_pressed("wheel_down"):
		wheelDown()
	if event.is_action_pressed("MoveN"):
		moveN(true)
	if event.is_action_pressed("MoveE"):
		moveE(true)
	if event.is_action_pressed("MoveS"):
		moveS(true)
	if event.is_action_pressed("MoveW"):
		moveW(true)
	if event.is_action_released("MoveN"):
		moveN(false)
	if event.is_action_released("MoveE"):
		moveE(false)
	if event.is_action_released("MoveS"):
		moveS(false)
	if event.is_action_released("MoveW"):
		moveW(false)

func wheelUp():
	cam3D.position = Vector3(0,0,cam3D.position.z-10)

func wheelDown():
	cam3D.position = Vector3(0,0,cam3D.position.z+10)

func moveN(isPressed: bool):
	if(isPressed):
		moveDirection = Vector3(moveDirection.x, moveDirection.y, moveDirection.z-1)
	else:
		print("released")
		moveDirection = Vector3(moveDirection.x, moveDirection.y, 0)

func moveE(isPressed: bool):
	if(isPressed):
		moveDirection = Vector3(moveDirection.x+1, moveDirection.y, moveDirection.z)
	else:
		moveDirection = Vector3(0, moveDirection.y, moveDirection.z)

func moveS(isPressed: bool):
	if(isPressed):
		moveDirection = Vector3(moveDirection.x, moveDirection.y, moveDirection.z+1)
	else:
		moveDirection = Vector3(moveDirection.x, moveDirection.y, 0)

func moveW(isPressed: bool):
	if(isPressed):
		moveDirection = Vector3(moveDirection.x-1, moveDirection.y, moveDirection.z)
	else:
		moveDirection = Vector3(0, moveDirection.y, moveDirection.z)
