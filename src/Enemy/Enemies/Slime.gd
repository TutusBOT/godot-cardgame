extends "res://src/Enemy/Enemy.gd"

var Absorption = preload("res://src/Effect/Effects/Absorption.tscn").instance()

func _ready() -> void:
	$Name.text = "Slime"
	init(30)
	Absorption.init(-1, self, 3)
	change_intent(Intent.ATTACK, 5)
	
func action():
	attack_animation()
	print(int(5 * damage_modifier), "slime dmg")
	GameState.Player.damage(int(5 * damage_modifier))
	end_turn()

func attack_animation():
	var tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "position", Vector2(position.x - 100, position.y), 0.1)
	tween.tween_property(self, "position", Vector2(position.x, position.y), 0.2)
