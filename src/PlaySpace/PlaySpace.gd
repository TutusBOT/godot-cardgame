extends Node2D

var FanTheHammer = preload("res://src/Card/Cards/FanTheHammer.tscn")
var Shoot = preload("res://src/Card/Cards/Shoot.tscn")
var Heal = preload("res://src/Card/Cards/Heal.tscn")
var Guard = preload("res://src/Card/Cards/Guard.tscn")

onready var card_oval_center = Vector2(1920, 1080) * Vector2(0.5, 1.3)
onready var card_oval_x_radius = 1920 * 0.45
onready var card_oval_y_radius = 1080 * 0.40
var card_oval_angle = deg2rad(90) - 0.2
var card_oval_angle_vector: Vector2

export var height_curve: Curve
export var spread_curve: Curve
export var rotation_curve: Curve

func _ready() -> void:
	for i in 4:
		var card = Shoot.instance()
		card.position = Vector2(960, 1080)
		GameState.Deck.push_back(card)
	for i in 4:
		var card = Guard.instance()
		card.position = Vector2(960, 1080)
		GameState.Deck.push_back(card)
	var heal = Heal.instance()
	heal.position = Vector2(960, 1080)
	GameState.Deck.push_back(heal)
	var fth = FanTheHammer.instance()
	fth.position = Vector2(960, 1080)
	GameState.Deck.push_back(fth)
	

func start_combat() -> void:
	$EndTurnButton.visible = true
	randomize()
	for card in GameState.Deck:
		var new_card = card.duplicate()
		GameState.DrawPile.push_back(new_card)
	GameState.DrawPile.shuffle()
	start_turn()

func end_combat() -> void:
	$EndTurnButton.visible = false
	for card in GameState.Hand:
		card.queue_free()
	GameState.Hand = []
	for card in GameState.DrawPile:
		card.queue_free()
	GameState.DrawPile = []
	for card in GameState.DiscardPile:
		card.queue_free()
	GameState.DiscardPile = []
	print("gamestate", GameState.Deck)

func draw(amount:int) -> void:
	for i in amount:
#		print("draw and disc", GameState.DrawPile.size(), GameState.DiscardPile.size())
		if GameState.DrawPile.size() < 1 and GameState.DiscardPile.size() < 1:
			print('Your deck is empty')
		else:
			if GameState.DrawPile.size() < 1:
				shuffle_discard()
			var card = GameState.DrawPile.pop_front()
			GameState.Hand.push_back(card)
			card.position = Vector2(50, 1000)
			card.rotation = 0
			card.scale = Vector2(0.5, 0.5)
			add_child(card)
	hand_position()
	print('starting draw anim', GameState.Hand)
	
	for card in GameState.Hand:

		var tween = create_tween()
		card.position = Vector2(50, 1000)
		tween.tween_property(card, "position", card.base_position, 0.1)
		tween.parallel().tween_property(card, "rotation", card.base_rotation, 0.1)
		tween.parallel().tween_property(card, "scale", Vector2(1, 1), 0.1)
		var timer = get_tree().create_timer(0.1, false)
		yield(timer, "timeout")
		timer = null
		card.enable()
	$EndTurnButton.disabled = false

func shuffle_discard():
	randomize()
	GameState.DiscardPile.shuffle()
	for i in GameState.DiscardPile.size():
		var card = GameState.DiscardPile.pop_back()
		GameState.DrawPile.push_back(card)

func end_turn() -> void:
	$EndTurnButton.disabled = true
	print('Ending turn')
	var current_hand = [] + GameState.Hand
#	print("hand", GameState.Hand, " child ", get_children())
	var last_card: Node2D = GameState.Hand[GameState.Hand.size() - 1]
	print(last_card, " last")
	for card in current_hand:
		print(card)
		card.discard()
	
#	for effect in GameState.Player.effects:
#		effect.end_turn()
#	for enemy in GameState.Enemies:
#		enemy.action()
#	print('starting turn')
#	start_turn()
	last_card.connect("discarded", self, "activate_all_effects", [], CONNECT_ONESHOT)
	

func activate_all_effects():
	for effect in GameState.Player.effects:
		effect.end_turn()
	for enemy in GameState.Enemies:
		enemy.action()
	start_turn()
	
func start_turn() -> void:
	GameState.Player.remove_block(GameState.Player.block)
	draw(10)
	GameState.resetEnergy()

func _on_Board_area_entered(area: Area2D) -> void:
	var selected_card = area.get_parent()
	print(selected_card, "selected")
	if selected_card.target_type == selected_card.TargetType.ALL:
		selected_card.should_play = true
	if selected_card.target_type == selected_card.TargetType.SELF:
		selected_card.should_play = true
		GameState.Player.get_node("Selected").visible = true


func _on_Board_area_exited(area: Area2D) -> void:
	var selected_card = area.get_parent()
	selected_card.should_play = false
	GameState.Player.get_node("Selected").visible = false	

func hand_position(reposition: = false):
	for i in GameState.Hand.size():
		var hand_ratio = 0.5
		var hand_spread = 75.0 * GameState.Hand.size()
		var height_spread = 80.0
		var rotation_spread = 0.3
		if GameState.Hand.size() > 1:
			hand_ratio = float(i) / float(GameState.Hand.size() - 1)
		if GameState.Hand.size() < 5:
			rotation_spread = 0.05
#			hand_spread = 200.0
#		if GameState.Hand.size() == 2:
#			hand_spread = 100.0
		var card = GameState.Hand[i]
		var destination_x = spread_curve.interpolate(hand_ratio) * hand_spread
		var destination_y = height_curve.interpolate(hand_ratio) * height_spread
		card.base_rotation = rotation_curve.interpolate(hand_ratio) * rotation_spread
		card.base_position = Vector2(960 + destination_x, 1080 - destination_y)
		if reposition:
			card.animate_mouse_exited()
			
