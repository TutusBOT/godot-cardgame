extends Control

var map: = []
var current_level: = []
var start_room
var boss_room
var test = 0

func _ready() -> void:
	GameState.Map = self
	generate()
	
func _process(delta: float) -> void:
	pass
#	if test < 2.1:
#		$ScrollContainer.scroll_vertical += 500 * delta
#		test += delta
	
func generate() -> void:
	var BaseTile = preload("res://src/Map/TextureButton.tscn")
	var EmptyTile = preload("res://src/Map/EmptyTile.tscn")
	var EnemyRoom = preload("res://src/Map/EnemyRoom/EnemyRoom.tscn")
	
	randomize()
	for i in 10:
		var vertical = HBoxContainer.new()
		vertical.set("custom_constants/separation", 200)
		vertical.alignment = BoxContainer.ALIGN_CENTER
		$ScrollContainer/GridContainer.add_child(vertical)
		var base = BaseTile.instance()
		if i == 0:
			vertical.add_child(base)
			boss_room = base
			# gorny
		elif i == 9:
			vertical.add_child(base)
			start_room = base
		else:
			var level: = []
			var room_min: = 5 if i == 5 else 2
			var random = int(rand_range(1, 15))
			for j in 5:
				var room
				if 5 - j == room_min:
					room_min -= 1
					room = EnemyRoom.instance()
				elif rand_range(0, 2) > 1:
					room = BaseTile.instance()
				else:
					room_min -= 1
					room = EnemyRoom.instance()
				
				# generate paths
				
				room.disabled = true
				vertical.add_child(room)
				level.push_back(room)
			map.push_back(level)
	current_level =  map[0]
	for room in current_level:
		room.disabled = false
	generate_paths()

func generate_paths() -> void:
	yield(get_tree().create_timer(0.00001), "timeout")
	for i in map.size():
		var level = map[i]
		for j in level.size():
			var room = level[j]
			var line = Line2D.new()
			if i == map.size() - 1:
				line.add_point(start_room.rect_global_position)
				line.add_point(room.rect_global_position)
#				print(line.points)
#				line.add_point(Vector2(832, 1808 ))
#				line.add_point(Vector2(280, 1638))
				$ScrollContainer/GridContainer.add_child(line)

func pick_next_level():
	var current_level_index = map.find(current_level)
	current_level = map[current_level_index + 1]
	for room in current_level:
		room.disabled = false

func room_choose():
	for room in current_level:
		room.disabled = true
	
func _on_Show_pressed() -> void:
	show_map()

func show_map() -> void:
	$Background.visible = !$Background.visible
	$ScrollContainer.visible = !$ScrollContainer.visible
	get_node("/root/Root/Battle").visible = !get_node("/root/Root/Battle").visible
