extends State

@onready var traderUI = $TraderUI_Testweise_Drinnen 

func _ready():
	traderUI.connect("endTrade",endTradeClicked)

func enter(_msg := {}) -> void:
	traderUI.setMoney()
	traderUI.show()

	#get_parent().transition_to("ChooseShipNumberState")
	#get_parent().transition_to("PlacePlayerState",{"shipName" : playerShips[0]})
	#get_parent().transition_to("ChooseBoardSizeState")


#	when the continue button of the shop gets clicked
func endTradeClicked():
	traderUI.hide()
	get_parent().transition_to("LevelEndState")
	
