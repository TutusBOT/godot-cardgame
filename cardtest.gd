extends Node2D

var selected = false
var base_position

func _process(delta: float) -> void:
	if selected:
		drag()

func _on_Area2D_mouse_entered() -> void:
	print('en')


func _on_Area2D_mouse_exited() -> void:
	print("ex")


func _on_Area2D_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		if event.is_pressed() == true:
			selected = true
		else:
			position = base_position
			selected = false
			scale = Vector2(1, 1)

func drag():
	position = get_global_mouse_position()
