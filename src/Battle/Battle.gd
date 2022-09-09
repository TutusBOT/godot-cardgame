extends Node2D

func _ready() -> void:
	GameState.Battle = self
	$Player.init(50)
	GameState.Player = $Player
	visible = false

func add_enemy(enemy: Node2D) -> void:
	GameState.Enemies.push_back(enemy)
	add_child(enemy)
	enemy.position = Vector2(1600, 800 - (enemy.get_node("Sprite").texture.get_height() * enemy.get_node("Sprite").scale.y))	

func add_memento(memento: Control) -> void:
	$Mementos.add_child(memento)
