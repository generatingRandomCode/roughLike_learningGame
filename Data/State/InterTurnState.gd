extends State

var roundTimer : int = 0
#@export var turnLabel : RichTextLabel

func _ready():
	$TimelineUI.hide()
#	called at the start of combat and at start of each round
func enter(parameter := {}) -> void:
	displayRoundTimer()
	await updateShips()
	get_parent().transition_to("EnemyState")


func updateShips():
	#	update the ship energy
	get_tree().call_group("Ship", "updateEnergy")
	#	update the ship ui
	get_tree().call_group("ShipUI", "updateShipUI")
	#updateEnergy

func displayRoundTimer():
	roundTimer += 1
	$TimelineUI.displayTurn(str(roundTimer))
	$TimelineUI.show()
