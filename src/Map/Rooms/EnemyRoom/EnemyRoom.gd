extends "res://src/Map/Rooms/Room.gd"
class_name EnemyRoom

var Slime = preload("res://src/Enemy/Enemies/Slime.tscn")
var Bandit = preload("res://src/Enemy/Enemies/Bandit.tscn")
var enemies_to_spawn = [[Bandit.instance()], [Slime.instance()]]

func _init() -> void:
	randomize()
	enemies_to_spawn = enemies_to_spawn[randi() % enemies_to_spawn.size()]

func press_action() -> void:
	for enemy in enemies_to_spawn:
		GameState.Battle.add_enemy(enemy)
	GameState.Map.show_map()
	GameState.Battle.get_node("PlaySpace").start_combat()
