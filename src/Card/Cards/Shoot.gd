extends "res://src/Card/Card.gd"

func _init() -> void:
	card_type = CardType.ATTACK

func _ready() -> void:
	target_type = TargetType.ENEMY
	cost = 1
	$Name.text = "Shoot"
	updateUI()

func effect() -> void:
	target.damage(5 * GameState.PlayerDamageModifier)

func updateUI():
	$Description.text = str("Deal ", int(5 * GameState.PlayerDamageModifier), " damage")
	$Cost.text = str(cost)
	
