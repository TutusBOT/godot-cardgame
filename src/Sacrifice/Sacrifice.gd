extends Node2D

func _on_Button_pressed() -> void:
	GameState.Map.pick_next_room()
