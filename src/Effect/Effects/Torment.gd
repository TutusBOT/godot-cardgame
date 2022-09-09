extends "res://src/Effect/Effect.gd"

var torment_type
enum TormentType {
	DEPRESSION,
	HOPE,
	DREAMS
}

func _init() -> void:
	randomize()
	effect_type = EffectType.TORMENT
	var torment_types = TormentType.keys()
	torment_type = TormentType[torment_types[randi() % torment_types.size()]]

func apply():
	match torment_type:
		TormentType.DEPRESSION:
			print('depression')
		TormentType.HOPE:
			print('hope')
		TormentType.DREAMS:
			print('dreams')
	
func wear_off():
	pass
	
