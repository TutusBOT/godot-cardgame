extends "res://src/Effect/Effect.gd"

const WEAK_MODIFIER = 0.75

func _init() -> void:
	effect_type = EffectType.WEAK
	description = "Attacks deal 50% less damage."

func apply():
	if target == GameState.Player:
		GameState.setPlayerDamageModifier(WEAK_MODIFIER)
	else:
		target.damage_modifier = WEAK_MODIFIER
	
func wear_off():
	if target == GameState.Player:
		GameState.setPlayerDamageModifier(1)
	else:
		target.damage_modifier = 1
	
