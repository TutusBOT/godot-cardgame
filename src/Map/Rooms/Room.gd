extends TextureButton

var point: Array

func _ready() -> void:
	rect_pivot_offset = texture_normal.get_size() / 2

func _on_Room_pressed() -> void:
	GameState.Map.current_room = self
	press_action()

func disable() -> void:
	self_modulate = Color(0.5, 0.5, 0.5, 1)
	disabled = true
	
func enable() -> void:
	self_modulate = Color(1.0, 1.0, 1.0, 1)
	disabled = false

func press_action() -> void:
	pass

func proceed() -> void:
	GameState.Map.pick_next_room()
