extends "res://src/Effect/Effect.gd"

func _init() -> void:
	effect_type = EffectType.HORROR
	apply_on_end = true
	description = "Decrease target's sanity by 1 at the end of a turn."
	effect_name = "Horror"

func apply():
	if target == GameState.Player:
		target.set_sanity(target.get_sanity() - 1)
	
