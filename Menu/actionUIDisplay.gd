extends Control
class_name actionUIDisplay

@export var iconListVar: Array[ImageTexture];
@export var titleVar: Array[String];
@export var descriptionVar: Array[String];
@export var actionUIParents: Array[Control];
@export var base: Control;


# Called when the node enters the scene tree for the first time.
func _ready():
	selectActionTab(0) #Test kann gelöscht werden
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func updateActions(iconList: Array[ImageTexture], title: Array[String], description: Array[String]):
	iconListVar = iconList
	titleVar = title
	descriptionVar = description
	selectActionTab(0)


func selectActionTab(tabNum: int):
	for n in actionUIParents.size():
		actionUIParents[n].visible = false
	actionUIParents[tabNum].visible = true
	if(iconListVar.size()>=1):
		actionUIParents[tabNum].get_node("Action1").visible = true
		actionUIParents[tabNum].get_node("Action1/TextureRect").texture = iconListVar[0]
	else:
		actionUIParents[tabNum].get_node("Action1").visible = false
	if(iconListVar.size()>=2):
		actionUIParents[tabNum].get_node("Action2").visible = true
		actionUIParents[tabNum].get_node("Action2/TextureRect").texture = iconListVar[1]
	else:
		actionUIParents[tabNum].get_node("Action2").visible = false
	if(iconListVar.size()>=3):
		actionUIParents[tabNum].get_node("Action3").visible = true
		actionUIParents[tabNum].get_node("Action3/TextureRect").texture = iconListVar[2]
	else:
		actionUIParents[tabNum].get_node("Action3").visible = false
	if(iconListVar.size()>=4):
		actionUIParents[tabNum].get_node("Action4").visible = true
		actionUIParents[tabNum].get_node("Action4/TextureRect").texture = iconListVar[3]
	else:
		actionUIParents[tabNum].get_node("Action4").visible = false
	if(iconListVar.size()>=5):
		actionUIParents[tabNum].get_node("Action5").visible = true
		actionUIParents[tabNum].get_node("Action5/TextureRect").texture = iconListVar[4]
	else:
		actionUIParents[tabNum].get_node("Action5").visible = false
	if(iconListVar.size()>=6):
		actionUIParents[tabNum].get_node("Action6").visible = true
		actionUIParents[tabNum].get_node("Action6/TextureRect").texture = iconListVar[5]
	else:
		actionUIParents[tabNum].get_node("Action6").visible = false
	
		
	self.get_node("Base/Titel").text = titleVar[tabNum]
	self.get_node("Base/Info").text = descriptionVar[tabNum]
	base.get_node("TextureRect2").texture = iconListVar[tabNum]
		




func _on_button_pressed():
	pass # Replace with function body.
