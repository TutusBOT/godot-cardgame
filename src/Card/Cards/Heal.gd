extends "res://src/Card/Card.gd"

func _ready() -> void:
	target_type = TargetType.SELF
	cost = 1
	$Cost.text = str(cost)
	$Description.text = "Heal 5"
	$Name.text = "Medkit"

func effect() -> void:
	GameState.Player.heal(5)
