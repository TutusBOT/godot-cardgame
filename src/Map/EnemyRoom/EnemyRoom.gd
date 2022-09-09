extends Button

var Bandit = preload("res://src/Enemy/Enemies/Bandit.tscn")
var Slime = preload("res://src/Enemy/Enemies/Slime.tscn")

var enemies_to_spawn: Array

func _init() -> void:
	var bandit = Bandit.instance()
	var slime = Slime.instance()
	enemies_to_spawn = [slime, bandit]
	enemies_to_spawn = enemies_to_spawn[randi() % enemies_to_spawn.size()]

func _on_EnemyRoom_pressed() -> void:
	var battle = get_node("/root/Root/Battle")
	for enemy in enemies_to_spawn:
		battle.add_enemy(enemy)
	GameState.Map.show_map()
	GameState.Map.room_choose()
	battle.get_node("PlaySpace").start_combat()
