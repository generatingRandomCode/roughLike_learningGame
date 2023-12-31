extends Path3D


var position1: Vector3;
var position2: Vector3;
@export var laserBeamThickness: float;
@export var Capsule: MeshInstance3D;
@export var pathFollow: PathFollow3D;
@export var fireParticle: GPUParticles3D;
@export var targetParticle: GPUParticles3D;
@export var isProjectile: bool;
@export var processParticleMaterial: ParticleProcessMaterial;
var progress: float;
var t: float

func _ready():
	var cur = Curve3D.new()
	self.curve = cur
	set_process(false)
	hide()

# Called when the node enters the scene tree for the first time.
func fire(action : ActionTemplate,timeout : float = 1):
	var position1 = self.global_position
	var position2 = action.targetField.global_position
	t = timeout
	curve.clear_points()
	curve.add_point(to_local(position1))
	curve.add_point(to_local(position2))
	fireParticle.set_position(to_local(position1))
	targetParticle.set_position(to_local(position2))
	if(isProjectile):
		pathFollow.set_progress_ratio(0)
		show()
		#Capsule.set_scale(Vector3(0.2, 1, 0.2))
		progress = 0.0
		set_process(true)
	else:
		fireParticle.process_material = processParticleMaterial
		targetParticle.process_material = processParticleMaterial
		pathFollow.set_progress_ratio(0.5)
		show()
		Capsule.set_scale(Vector3(laserBeamThickness, curve.get_baked_length()/2, laserBeamThickness))
	if !action.targetField.has_node("Model"):
		var distance = curve.get_baked_length()
		curve.clear_points()
		curve.add_point(to_local(position1))
		curve.add_point(to_local(position2*2))
		if isProjectile:
			progress = 0.0
			await get_tree().create_timer(timeout*2).timeout
			t = t*curve.get_baked_length()/distance
	
	await get_tree().create_timer(timeout).timeout
	set_process(false)
	if action.targetField.has_node("Model"):
		get_parent().executeDamageAction(action.targets)
		targetParticle.emitting = true
		
	await get_tree().create_timer(0.2).timeout
	hide()
	curve.clear_points()

func _process(delta):
	progress += delta/t
	pathFollow.set_progress_ratio(progress)
