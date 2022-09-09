extends Control

var deck: Array

func _on_ShowDeck_pressed() -> void:
	$ScrollContainer.visible = !$ScrollContainer.visible
	if $ScrollContainer.visible:
		var rows_amount = int(ceil(deck.size() / 5))
		for i in rows_amount:
			var vertical = HBoxContainer.new()
			vertical.set("custom_constants/separation", 150)
			$ScrollContainer/GridContainer.add_child(vertical)
		for i in deck.size():
			var row = int(ceil(i / 5)) + 1
			var row_node = $ScrollContainer/GridContainer.get_child(row)
			var control = Control.new()
			control.rect_size = Vector2(192, 256)
			print(row_node, control.rect_size)
			row_node.add_child(control)
			control.add_child(deck[i])
		yield(get_tree().create_timer(0.001), "timeout")
		for row in $ScrollContainer/GridContainer.get_children():
			if row is MarginContainer:
				pass
			else:
				for card_container in row.get_children():
					card_container.get_child(0).disable()
					card_container.get_child(0).position = card_container.rect_global_position
	else:
		for row in $ScrollContainer/GridContainer.get_children():
			if row is MarginContainer:
				pass
			else:
				for card_container in row.get_children():
					card_container.remove_child(card_container.get_child(0))
				row.queue_free()
	

func init(deck_to_display: Array):
	deck = deck_to_display
	
