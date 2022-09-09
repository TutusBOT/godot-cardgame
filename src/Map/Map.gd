extends Node2D

var sacrificeRoom = preload("res://src/Map/Rooms/SacrificeRoom/SacrificeRoom.tscn")
var enemyRoom = preload("res://src/Map/Rooms/EnemyRoom/EnemyRoom.tscn")
const X_MARGIN = 300
const Y_MARGIN = 100

var paths_amount: int
var paths_length: int
var paths: Array
var path_texture = preload("res://assets/Map/Path.png")
var rooms: Array
var current_room setget set_current_room
var current_level

func _ready() -> void:
	GameState.Map = self
	generate(5, 7)

func generate(paths_amount, paths_length):
	# setup
	for child in $Rooms.get_children():
		child.queue_free()
	paths = []
	rooms = []
	for i in paths_length + 2:
		rooms.append([])
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	
	# generation
	for i in paths_amount - 1:
		var current_path = []
		var base_point = [int(ceil(paths_amount / 2.0)), 0]
		current_path.append(base_point)
		var starting_point = [rng.randi_range(1, 5), 1]
		current_path.append(starting_point)
		for j in paths_length - 1:
			var current_point
			var y = j + 2
			var x = current_path[j + 1][0] + rng.randi_range(-1, 1)
			if x == 0:
				x = 1
			elif x == paths_amount + 1:
				x = paths_amount
			current_point = [x, y]
			current_path.append(current_point)
		var end_point = [int(ceil(paths_amount / 2.0)), paths_length + 1]
		current_path.append(end_point)
		paths.append(current_path)
	for path in paths:
		print(path)
		var previous_room
		for j in path.size():
			var point = path[j]
			# line generation
			if j != 0:
				var line = Line2D.new()
				line.add_point(Vector2(X_MARGIN + path[j - 1][1] * 150, Y_MARGIN + path[j - 1][0] * 150))
				line.add_point(Vector2(X_MARGIN + point[1] * 150, Y_MARGIN + point[0] * 150))
				line.texture = path_texture
				line.texture_mode = Line2D.LINE_TEXTURE_TILE
				line.width = 5
				line.joint_mode = Line2D.LINE_JOINT_ROUND
				$Rooms.add_child(line)
			
			# room generation
			var room: TextureButton
			var room_exists: = false
			for indicator in rooms[point[1]]:
				if indicator[0] == point[0]:
					previous_room = indicator[1]
					room_exists = true
			if room_exists:
				continue
			if j == 0:
				room = enemyRoom.instance()
			else:
				var random = rng.randi_range(1, 100)
				print('r ', random)
				if random < 11 and !(previous_room is SacrificeRoom):
					room = sacrificeRoom.instance()
				else:
					room = enemyRoom.instance()
			room.point = point
			room.rect_global_position = Vector2(X_MARGIN + point[1] * 150 - room.texture_normal.get_size().x / 2, Y_MARGIN + point[0] * 150 - room.texture_normal.get_size().y / 2)
			room.disable()
			rooms[point[1]].append([point[0], room])
			previous_room = room
			$Rooms.add_child(room)
	set_current_room(rooms[0][0][1])
	pick_next_room()
#	print("")
#	for room in rooms:
#		print(room)

func pick_next_room() -> void:
	for i in rooms.size():
		if rooms[i].find(current_room) != -1:
			current_level = i
	var available_rooms: = []
	for path in paths:
		if path[current_level][0] == current_room[0]:
			available_rooms.append(path[current_level + 1][0])
	for room in rooms[current_level + 1]:
		if available_rooms.find(room[0]) != -1:
			room[1].enable()

func set_current_room(room: TextureButton) -> void:
	current_room = [room.point[0], room]
	for i in rooms.size():
		for room in rooms[i]:
			room[1].disable()


func _on_VisiblityButton_pressed() -> void:
	show_map()

func show_map() -> void:
	$Background.visible = !$Background.visible
	$Rooms.visible = !$Rooms.visible
	GameState.Battle.visible = !GameState.Battle.visible
