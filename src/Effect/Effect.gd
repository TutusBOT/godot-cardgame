extends Control

var amount: int
var duration: int
var target: Node2D
var apply_on_end: = false
onready var effect_type
enum EffectType {
	WEAK,
	FRAGILE,
	HORROR,
	TORMENT,
	ABSORPTION
}
var description: String
var effect_name: String

func init(effect_duration: int, effect_target: Node2D, value = -1):
	if value != -1:
		amount = value
		$Amount.show()
	duration = effect_duration
	if effect_duration == -1:
		duration = INF
		$Time.hide()
	target = effect_target
	var is_affected = false
	for effect in target.effects:
		if effect.effect_type == effect_type:
			is_affected = true
			effect.duration += effect_duration
			effect.update_UI()
	if !is_affected:
		target.effects.push_back(self)
		target.get_node("Effects").add_child(self)
		if !apply_on_end:
			apply()
	update_UI()

func end_turn():
	duration -= 1
	update_UI()
	apply()
	if duration == 0:
		wear_off()
		get_parent().get_parent().effects.erase(self)
		queue_free()

func apply():
	pass

func wear_off():
	pass

func update_UI():
	$Time.text = str(duration)
	$Amount.text = str(amount)
