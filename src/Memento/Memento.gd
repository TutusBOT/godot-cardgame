extends TextureButton

class_name Memento

var description: String
var memento_name: String

func _on_Memento_mouse_entered() -> void:
	$Tooltip.update()
	$Tooltip.visible = true

func _on_Memento_mouse_exited() -> void:
	$Tooltip.visible = false

func on_pickup() -> void:
	print('picked up!')

func _on_Memento_pressed() -> void:
	$Tooltip.visible = false
	get_parent().remove_child(self)
	GameState.Battle.add_memento(self)
	on_pickup()
