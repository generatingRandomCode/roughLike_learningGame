# Generic state machine. Initializes states and delegates engine callbacks
# (_physics_process, _unhandled_input) to the active state.
class_name StateMachine
extends Node

# Emitted when transitioning to a new state.
signal transitioned(state_name)

# Path to the initial active state. We export it to be able to pick the initial state in the inspector.
var state;
var initial_state
# The current active state. At the start of the game, we get the `initial_state`.


func _ready():
	initial_state = $GameStart
	state = initial_state
	# The state machine assigns itself to the State objects' state_machine property.
	for child in get_children():
		child.state_machine = self
	state.enter()


# The state machine subscribes to node callbacks and delegates them to the state objects.
func _unhandled_input(event: InputEvent) -> void:
	#state.handle_input(event)
	pass

func _process(delta: float) -> void:
	#state.update(delta)
	pass

func _physics_process(delta: float) -> void:
	#state.physics_update(delta)
	pass

# This function calls the current state's exit() function, then changes the active state,
# and calls its enter function.
# It optionally takes a `msg` dictionary to pass to the next state's enter() function.
func transition_to(target_state_name: String, msg: Dictionary = {}) -> void:
	print("current state: ", state)
	# Safety check, you could use an assert() here to report an error if the state name is incorrect.
	# We don't use an assert here to help with code reuse. If you reuse a state in different state machines
	# but you don't want them all, they won't be able to transition to states that aren't in the scene tree.
	if not has_node(target_state_name):
		#	wenn nicht da versuchen die scene zu laden?
		#var stateScene = 
		return
	print("transition to ",target_state_name)
	if state != null:
		state.exit()
		print("current State:", state)
		state.process_mode = 4 # Disable
		state.hide()
		#	to stop cross signals
		#state.queue_free()
	state = get_node(target_state_name)
	#state.paused = false
	state.enter(msg)
	emit_signal("transitioned", state.name)