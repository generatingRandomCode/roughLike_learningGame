extends State

func enter(_msg := {}) -> void:
	get_node("../../Menu").show()
	print("gameStart")
	

# Called when the node enters the scene tree for the first time.
#	die ready funktio hier ist blöd, wird vor der state mashine ausgeführt
func _ready():
	print("gamestart")
	#get_parent().transition_to("TestState", {})


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print("gameone")
	pass
