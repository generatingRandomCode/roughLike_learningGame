extends Path3D


var position1: Vector3;
var position2: Vector3;
@export var Capsule: MeshInstance3D;
@export var pathFollow: PathFollow3D;
@export var fireParticle: GPUParticles3D;
@export var targetParticle: GPUParticles3D;

# Called when the node enters the scene tree for the first time.
func fire(position1: Vector3,position2: Vector3, timeout : float = 1):
	curve.add_point(to_local(position1))
	curve.add_point(to_local(position2))
	fireParticle.position = to_local(position1)
	targetParticle.position = to_local(position2)
	pathFollow.progress_ratio = 0.5
	show()
	Capsule.scale = (Vector3(2, curve.get_baked_length()/2, 2))
	await get_tree().create_timer(timeout).timeout
	hide()
	curve.clear_points()

