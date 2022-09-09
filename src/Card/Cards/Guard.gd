extends "res://src/Card/Card.gd"

func _init() -> void:
	card_type = CardType.ABILITY

func _ready() -> void:
	target_type = TargetType.SELF
	cost = 1
	$Name.text = "Guard"
	$Cost.text = str(cost)
	$Description.text = "Gain 5 block."

func effect() -> void:
	GameState.Player.add_block(5)
