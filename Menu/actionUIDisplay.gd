extends Control
class_name actionUIDisplay



@export var descriptionVar: Array[String];
#	6 ActionTabs
@export var actionUIParents: Array[Control];
@export var base: Control;



var currentActionIDs : Array
var actions
var actionCurrent


signal actionChoosen
signal skipAction


# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("ActionUI")
	hide()
	#selectActionTab(0) #Test kann gelöscht werden

func updateActions(actions: Array[Node]):
	self.actions = actions
	selectActionTab(0)


func selectActionTab(tabNum: int):
	for n in actionUIParents:
		n.hide()
	actionUIParents[tabNum].show()

	for n in 6:
		actionUIParents[tabNum].get_node("Action"+ str(n+1)).visible = false

	for n in actions.size():
		actionUIParents[tabNum].get_node("Action" + str(n+1)).visible = true
		actionUIParents[tabNum].get_node("Action" + str(n+1)).visible = true
		actionUIParents[tabNum].get_node("Action" + str(n+1) + "/TextureRect").texture = actions[n].icon

	if tabNum < actions.size() :
		print("BonusAction: ",actions[tabNum].actionType )
		self.get_node("Base/Titel").text = actions[tabNum].wepon_name
		self.get_node("Base/Info").text = "Action Type: " + ("BonusAction" if actions[tabNum].actionType else "Action") + "\n"
		self.get_node("Base/Info").text += str(actions[tabNum].description)
		base.get_node("TextureRect2").texture = actions[tabNum].icon
		actionCurrent = actions[tabNum]


func _on_fire_pressed():
	#	hot to skip
	if actionCurrent:
		actionChoosen.emit(actionCurrent)

func _on_skip_press():
	skipAction.emit()
