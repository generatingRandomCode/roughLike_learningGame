extends Path3D


var position1: Vector3;
var position2: Vector3;
@export var Capsule: MeshInstance3D;
@export var pathFollow: PathFollow3D;
@export var fireParticle: GPUParticles3D;
@export var targetParticle: GPUParticles3D;

func _ready():
	hide()

# Called when the node enters the scene tree for the first time.
func fire(position1: Vector3,position2: Vector3, timeout : float = 1):
	curve.clear_points()
	curve.add_point(to_local(position1))
	curve.add_point(to_local(position2))
	fireParticle.set_position(to_local(position1))
	targetParticle.set_position(to_local(position2))
	pathFollow.set_progress_ratio(0.5)
	show()
	Capsule.set_scale(Vector3(0.3, curve.get_baked_length()/2, 0.3))
	await get_tree().create_timer(timeout).timeout
	hide()
	curve.clear_points()

