extends VBoxContainer

var icon setget set_icon
var title setget set_title
var description setget set_description

func set_icon(new_icon) -> void:
	icon = new_icon
	$Header/Icon.texture = new_icon
	
func set_title(new_title) -> void:
	title = new_title
	$Header/Title.text = new_title
	
func set_description(new_description) -> void:
	description = new_description
	$Description.text = new_description
