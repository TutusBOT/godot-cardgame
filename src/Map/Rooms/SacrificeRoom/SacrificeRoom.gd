extends "res://src/Map/Rooms/Room.gd"
class_name SacrificeRoom

var sacrifice = preload("res://src/Sacrifice/Sacrifice.tscn").instance()

func press_action() -> void:
	var root: Node2D = get_node("/root/Root")
	root.add_child(sacrifice)
	GameState.Map.show_map()
