extends baseAction

class_name BaseAntriebe

@export var moveDistance : int
#	moves x filds
func move(cause, target):
	print("field test: ", target)
	if !target.has_node("Model"):
		cause.get_parent().remove_child(cause)
		target.add_child(cause)
	
	
#	get the player position

#	get all the fids with distance 1

# 	rule out all filds with ships 

#	return 
