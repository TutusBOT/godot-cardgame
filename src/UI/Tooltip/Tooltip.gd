extends MarginContainer

var Content = preload("res://src/UI/Tooltip/TooltipContent.tscn")

onready var parent = get_parent()
const WIDTH = 200

#func init(comments: Array, parent: Node2D, x_offset: int) -> void:
#	for comment in comments:
#		var text_node = Label.new()
#		text_node.text = comment
#		$Container.add_child(text_node)
#	var tooltip_position
#	if parent.position + Vector2(WIDTH, 0) < OS.get_real_window_size():
#		tooltip_position = parent.position + Vector2(x_offset, 0)
#	else:
#		tooltip_position = parent.position - Vector2(x_offset, 0)
#	rect_global_position = tooltip_position

func _ready() -> void:
	visible = false
	var tooltip_position
	var sprite = parent.get_node_or_null("Sprite")
	var offset: float
	if sprite:
		offset = (sprite.texture.get_size().x * sprite.scale.x)/ 2 + WIDTH
	else: 
		offset = 300 + WIDTH
	print(offset ,'off')
	if parent is Enemy:
		tooltip_position = parent.position - Vector2(offset, 0)
	elif parent is Memento:
		tooltip_position = parent.rect_position + Vector2(0, 50)
	elif parent.position + Vector2(WIDTH, 0) < OS.get_real_window_size():
		tooltip_position = parent.position + Vector2(offset, 0)
	else:
		tooltip_position = parent.position - Vector2(offset, 0)
	rect_global_position = tooltip_position
	update()

func update() -> void:
	for child in $Container.get_children():
		child.queue_free()
	if parent is Enemy:
		var intent = Content.instance()
		intent.description = parent.intent_description
		intent.icon = parent.get_node("Intent").texture
		$Container.add_child(intent)
		for effect in parent.effects:
			var content = Content.instance()
			content.icon = effect.get_node("Icon").texture
			content.description = effect.description
			content.title = effect.effect_name
			$Container.add_child(content)
	elif parent is Card:
		pass
	elif parent is Memento:
		var content = Content.instance()
		print(parent.description)
		content.description = parent.description
		content.title = parent.memento_name
		$Container.add_child(content)
	elif parent is Player:
		for effect in parent.effects:
			var content = Content.instance()
			content.icon = effect.get_node("Icon").texture
			content.description = effect.description
			content.title = effect.effect_name
			$Container.add_child(content)
	else:
		print('invalid parent for tooltip')
