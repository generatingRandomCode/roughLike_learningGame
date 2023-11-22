extends Node3D


func getWepondInitative(action,cause):
	var ship = instance_from_id(cause)
	return ship.get_node(str(action)).wepon_initiative
