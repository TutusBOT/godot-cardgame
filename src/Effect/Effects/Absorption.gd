extends "res://src/Effect/Effect.gd"

func _init() -> void:
	effect_type = EffectType.ABSORPTION
	description = "This creature recieves X less damage."
	effect_name = "Absorption"

func apply():
	target.absorption = amount
	
func wear_off():
	target.absorption = 0
	
