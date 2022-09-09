extends Node2D

class_name Card

var font = preload("res://assets/Fonts/Font.tres").duplicate()

var selected = false
var playing = false

var base_position: Vector2 = Vector2(200, 200)
var base_rotation

var should_play = false
var stats
var disabled = false
var cost
var target
var target_type
enum TargetType {
	SELF,
	ENEMY,
	ALL,
	NONE
}
var card_type
enum CardType {
	ATTACK,
	ABILITY
}

signal discarded

func _ready() -> void:
	$Cost.add_font_override("font", font)
	$Description.add_font_override("font", font)
	$Name.add_font_override("font", font)	
	if card_type == CardType.ATTACK:
		GameState.connect("damage_modifier_updated", self, "updateUI")

func disable():
	disabled = true
	
func enable():
	disabled = false
	
func _process(delta: float) -> void:
	if disabled:
		return
	if selected:
		drag()
	elif should_play:
		play()
		
func drag():
	position = get_global_mouse_position()

func play():
	print('play')
	var current_energy = GameState.getEnergy()
	should_play = false
	if current_energy >= cost:
		playing = true
		effect()
		GameState.setEnergy(GameState.getEnergy() - cost)
		discard()
	else:
		print("Too low energy")
#
func effect() -> void:
	pass

func discard():
	disable()
	var tween = create_tween()
	tween.set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "position", Vector2(1800, 1000), 0.5)
	tween.parallel().tween_property(self, "scale", Vector2(0.5, 0.5), 0.2)
	tween.parallel().tween_property(self, "rotation", 0, 0.2)
	yield(tween, "finished")
	GameState.Hand.pop_at(GameState.Hand.find(self))
	scale = Vector2(1, 1)
	rotation = 0
	playing = false
	GameState.Battle.get_node("PlaySpace").hand_position(true)
	GameState.DiscardPile.push_back(self)
	get_parent().remove_child(self)
	emit_signal("discarded")
	print('discarded')
	

func updateUI():
	print('update')

func _on_Control_mouse_entered() -> void:
	print(self, 'entered')
	if disabled or selected:
		return
	var index = GameState.Hand.find(self)
	for i in GameState.Hand.size():
		var card = GameState.Hand[i]
		var tween = create_tween()
		if i == index:
			pass
		else:
			pass
#			tween.tween_property(card, "position", Vector2(card.base_position.x + 200 / (2 * (i - index)), card.base_position.y), 0.2)
	rotation = 0
	scale = Vector2(1.2, 1.2)
	$Cost.rect_scale = Vector2(0.85, 0.85)
	$Description.rect_scale = Vector2(0.85, 0.85)
	$Name.rect_scale = Vector2(0.85, 0.85)
	font.size = 20
	z_index = 11
	var tween = create_tween()
	tween.tween_property(self, "position", Vector2(base_position.x, 1080 - 128), 0.1)


func _on_Control_mouse_exited() -> void:
	if disabled or selected or playing:
		return
	var index = GameState.Hand.find(self)
	for i in GameState.Hand.size():
		var card = GameState.Hand[i]
		var tween = create_tween()
		if i == index:
			pass
		else:
			pass
#			print(card, 'animatd')
#			tween.tween_property(card, "position", Vector2(card.base_position.x, card.base_position.y), 0.1)
	z_index = 10
	$Cost.rect_scale = Vector2(1, 1)
	$Description.rect_scale = Vector2(1, 1)
	$Name.rect_scale = Vector2(1, 1)
	font.size = 16
	animate_mouse_exited()

func animate_mouse_exited() -> void:
	if disabled:
		return
	var tween = create_tween().set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "position", base_position, 0.1)
	tween.parallel().tween_property(self, "rotation", base_rotation, 0.1)
	tween.parallel().tween_property(self, "scale", Vector2(1, 1), 0.1)

func _on_Control_gui_input(event: InputEvent) -> void:
	if disabled:
		return
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		if event.is_pressed() == true:
			selected = true
			scale = Vector2(1.2, 1.2)
			rotation = 0
		else:
			print(should_play)
			z_index = 10
			animate_mouse_exited()
			selected = false
			
