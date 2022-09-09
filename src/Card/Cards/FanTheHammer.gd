extends "res://src/Card/Card.gd"

func _init() -> void:
	card_type = CardType.ATTACK

func _ready() -> void:
	target_type = TargetType.ALL
	cost = GameState.Energy
	$Name.text = "Fan the Hammer"
	GameState.connect("energy_updated", self, "updateUI")
	updateUI()

func effect() -> void:
	for i in cost:
		randomize()
		GameState.Enemies[randi() % GameState.Enemies.size()].damage((5 + i) * GameState.PlayerDamageModifier)

func updateUI():
	cost = GameState.Energy
	$Description.text = str("Deal ", int(5 * GameState.PlayerDamageModifier), " damage to a random enemy. Do it ", cost, " times. For each energy spent deal 1 damage more.")
	$Cost.text = str(cost)
