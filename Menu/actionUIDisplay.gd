extends Control
class_name actionUIDisplay

@export var iconListVar: Array[ImageTexture];
@export var titleVar: Array;
@export var descriptionVar: Array[String];
#	6 ActionTabs
@export var actionUIParents: Array[Control];
@export var base: Control;
var currentActionIDs : Array

var currentActionID : int

signal actionChoosen

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("ActionUI")
	hide()
	#selectActionTab(0) #Test kann gelöscht werden


func updateActions(actions: Array[Node], description: Array[String] = [], iconList: Array[ImageTexture] = []):
	print("ACTIONUI: function call",titleVar)
	iconListVar = iconList
	titleVar = actions.map(func(x): return x.wepon_name)
	currentActionIDs = actions.map(func(x): return x.get_instance_id())
	descriptionVar = description
	selectActionTab(0)


func selectActionTab(tabNum: int):
	print("testButton:" , currentActionID)
	for n in actionUIParents:
		n.hide()
	actionUIParents[tabNum].show()
	for n in 6:
		actionUIParents[tabNum].get_node("Action"+ str(n+1)).visible = false

	for n in titleVar.size():
		actionUIParents[tabNum].get_node("Action" + str(n+1)).visible = true
		#	#actionUIParents[tabNum].get_node("Action" + str(n+1) + "/TextureRect").texture = iconListVar[0]

	if tabNum < titleVar.size():
		print("ACTIONUI: ",titleVar)
		self.get_node("Base/Titel").text = titleVar[tabNum]
		#self.get_node("Base/Info").text = descriptionVar[tabNum]
		self.get_node("Base/Info").text = titleVar[tabNum]
		#base.get_node("TextureRect2").texture = iconListVar[tabNum]
		currentActionID = currentActionIDs[tabNum]


func _on_fire_pressed():
	print("testButtonEnde:" , currentActionID)
	var test = instance_from_id(currentActionID)	
	print("testButtonEnde:" , test)
	print("testButtonEnde:" , test.name)
	if currentActionID:
		actionChoosen.emit(currentActionID)

