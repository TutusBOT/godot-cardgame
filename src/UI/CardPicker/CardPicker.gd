extends Node2D

var Shoot = preload("res://src/Card/Cards/Shoot.tscn")
var Heal = preload("res://src/Card/Cards/Heal.tscn")

var CardsList = [
	Shoot,
	Heal
]

var selected_card = 0

func _ready() -> void:
	print(Shoot)
	for i in 3:
		randomize()
		var card = CardsList[randi() % CardsList.size()].instance()
		var parent = get_child(i)
		card.disable()
		card.get_node("Collision/CollisionShape2D").disabled = true
		parent.add_child(card)


func _on_card1_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_pressed() and event.button_index == BUTTON_LEFT and selected_card == 1:
		var card1 = $Card1.get_child(1).duplicate()
		card1.enable()
		card1.get_node("Collision/CollisionShape2D").disabled = false
		GameState.Deck.push_back(card1)
		queue_free()


func _on_card2_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_pressed() and event.button_index == BUTTON_LEFT and selected_card == 2:
		var card2 = $Card2.get_child(1).duplicate()
		card2.enable()
		card2.get_node("Collision/CollisionShape2D").disabled = false
		GameState.Deck.push_back(card2)
		queue_free()


func _on_card3_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_pressed() and event.button_index == BUTTON_LEFT and selected_card == 3:
		var card3 = $Card3.get_child(1).duplicate()
		card3.enable()
		card3.get_node("Collision/CollisionShape2D").disabled = false
		GameState.Deck.push_back(card3)
		queue_free()


func _on_card1_mouse_entered() -> void:
	selected_card = 1

func _on_card1_mouse_exited() -> void:
	selected_card = 0

func _on_card2_mouse_entered() -> void:
	selected_card = 2

func _on_card2_mouse_exited() -> void:
	selected_card = 0

func _on_card3_mouse_entered() -> void:
	selected_card = 3

func _on_card3_mouse_exited() -> void:
	selected_card = 0
