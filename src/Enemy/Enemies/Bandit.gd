extends "res://src/Enemy/Enemy.gd"

func _ready() -> void:
	init(50)

func action():
	if turn % 2 == 0:
		attack_animation()
		GameState.Player.damage(5 * damage_modifier)
	else:
		heal(5)
	end_turn()

func attack_animation():
	var tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "position", Vector2(position.x - 100, position.y), 0.1)
	tween.tween_property(self, "position", Vector2(position.x, position.y), 0.2)
