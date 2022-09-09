extends Node2D

var Weak = preload("res://src/Effect/Effects/Weak.tscn")
var Horror = preload("res://src/Effect/Effects/Horror.tscn")
var Bandit = preload("res://src/Enemy/Enemies/Bandit.tscn")

func _ready() -> void:
	var horror = Horror.instance()
	horror.init(3, GameState.Player)
	$DeckViewer.init(GameState.Deck)
