extends "res://src/Memento/Memento.gd"

var uses: = 2

func _init() -> void:
	GameState.Vivere = self
	memento_name = "Vivere"
	description = str("When you die resurrect with 10% of your Max HP. ", uses, " uses left.")

func use() -> void:
	uses -= 1
	GameState.Player.heal(int(GameState.Player.max_health * 0.1))
	var uses_string: = "uses"
	if uses == 1:
		uses_string = "use"
	description = str("When you die resurrect with 10% of your Max HP. ", uses, " ", uses_string," left.")
	$Tooltip.text = description
