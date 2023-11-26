extends Node3D

@export var cam3D: Camera3D;
var moveDirection: Vector3;
var rotateDirection: Vector3;
@export var moveSpeed: float;
var mouseInsideCam = false;
var startPosition: Vector3;
var startRotation: Vector3;
@export var positionNode: Node3D;
var maxZoom = 150
var minZoom = 15
var minRotation = -60
var maxRotation = 60
@export var playerDisplay: bool;


# Called when the node enters the scene tree for the first time.
func _ready():
	moveDirection = Vector3(0,0,0)
	rotateDirection = Vector3(0,0,0)
	startPosition = positionNode.position
	startRotation = self.rotation_degrees

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	positionNode.position = Vector3(positionNode.position.x+moveDirection.x*delta*moveSpeed, positionNode.position.y+moveDirection.y*delta*moveSpeed, positionNode.position.z+moveDirection.z*delta*moveSpeed)
	if(minRotation<rotation_degrees.y+rotateDirection.y*delta*moveSpeed && maxRotation>rotation_degrees.y+rotateDirection.y*delta*moveSpeed):
		rotation_degrees = Vector3(rotation_degrees.x+rotateDirection.x*delta*moveSpeed, rotation_degrees.y+rotateDirection.y*delta*moveSpeed, rotation_degrees.z+rotateDirection.z*delta*moveSpeed)

func _input(event):
	if(mouseInsideCam):
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
		if event.is_action_pressed("TurnRight"):
			turnRight(true)
		if event.is_action_pressed("TurnLeft"):
			turnLeft(true)
		if event.is_action_released("TurnRight"):
			turnRight(false)
		if event.is_action_released("TurnLeft"):
			turnLeft(false)
		if event.is_action_pressed("resetView"):
			positionNode.position = startPosition
			rotation_degrees = startRotation



func wheelUp():
	if(minZoom<cam3D.position.z-10):
		cam3D.position = Vector3(0,0,cam3D.position.z-10)

func wheelDown():
	if(maxZoom>cam3D.position.z+10):
		cam3D.position = Vector3(0,0,cam3D.position.z+10)

func moveN(isPressed: bool):
	if(isPressed):
		moveDirection = Vector3(moveDirection.x, moveDirection.y, moveDirection.z-1)
	else:
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

func turnRight(isPressed: bool):
	if(isPressed):
		rotateDirection = Vector3(0, rotateDirection.y+1, 0)
	else:
		rotateDirection = Vector3(0, 0, 0)


func turnLeft(isPressed: bool):
	if(isPressed):
		rotateDirection = Vector3(0, rotateDirection.y-1, 0)
	else:
		rotateDirection = Vector3(0, 0, 0)

func _on_sub_viewport_container_mouse_entered():
	if(playerDisplay):
		mouseInsideCam = true;


func _on_sub_viewport_container_mouse_exited():
	if(playerDisplay):
		mouseInsideCam = false;
	moveDirection = Vector3(0,0,0)


func _on_sub_viewport_container_2_mouse_entered():
	if(!playerDisplay):
		mouseInsideCam = true;


func _on_sub_viewport_container_2_mouse_exited():
	if(!playerDisplay):
		mouseInsideCam = false;
	moveDirection = Vector3(0,0,0)
