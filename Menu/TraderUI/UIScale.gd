extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_trader_ui_resized():
	var x : float = DisplayServer.window_get_size().x
	var y : float = DisplayServer.window_get_size().y
	if(x/1920 > y/1080):
		self.scale = Vector2(y/1080,y/1080)
	else:
		self.scale = Vector2(x/1920,x/1920)

