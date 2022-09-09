extends Node2D

class_name Enemy

var Reward = preload("res://src/UI/CardPicker/CardPicker.tscn")

var max_health: int
var health: int
var turn: int
var effects = []
var damage_modifier:= 1.0
var absorption: = 0

enum Intent {
	ATTACK,
	BLOCK,
	HEAL
}
var intent_description: String
var IntentAttack = preload("res://assets/Default (64px)/sword.png")
var IntentHeal = preload("res://assets/Default (64px)/suit_hearts.png")
var IntentBlock = preload("res://assets/Default (64px)/structure_wall.png")


signal card_entered(target)
signal card_exited(target)

func init(hp:int):
	max_health = hp
	health = max_health
	$HealthBar.max_value = max_health
	updateHealthUI()

func damage(amount: int):
	var damage = (amount * damage_modifier) - absorption
	if damage > 0:
		health -= damage
	updateHealthUI()
	if health < 1:
		die()

func heal(amount: int):
	health += amount
	if health > max_health:
		health = max_health
	updateHealthUI()

func end_turn():
	turn += 1
	for effect in effects:
		effect.end_turn()


func die():
#	animation
	yield(get_tree().create_timer(1), "timeout")
#	spawn card picker
	var reward = Reward.instance()
	get_parent().add_child(reward)
	if GameState.Enemies.size() == 1:
		GameState.Enemies = []
		GameState.Map.pick_next_room()
		get_node("/root/Root/Battle/PlaySpace").end_combat()
	queue_free()

func updateHealthUI():
	$Health.text = str(health, "/", max_health)
	$HealthBar.value = health


func _on_Area2D_area_entered(area: Node2D) -> void:
	var selected_card = area.get_parent()
	if selected_card.target_type == selected_card.TargetType.ENEMY:
		$Selected.visible = true
		selected_card.should_play = true
	area.get_parent().target = self
	emit_signal("card_entered", self)


func _on_Area2D_area_exited(area: Area2D) -> void:
	var selected_card = area.get_parent()	
	$Selected.visible = false
	if selected_card.target_type == selected_card.TargetType.ENEMY:
		selected_card.should_play = false	
	if selected_card.target == self:
		selected_card.target = null
	emit_signal("card_exited", self)
	
func set_damage_modifier(value: float) -> void:
	damage_modifier = value

func change_intent(intent, amount: int) -> void:
	$Intent/Amount.text = str(amount)
	match intent:
		Intent.ATTACK:
			intent_description = str("This creature intends to attack for ", amount, " damage.")
			$Intent.texture = IntentAttack
		Intent.BLOCK:
			intent_description = str("This creature intends to block.")
			$Intent.texture = IntentBlock
		Intent.HEAL:
			intent_description= str("This creature intends to heal.")
			$Intent.texture = IntentHeal


func _on_Area2D_mouse_entered() -> void:
	var tween = create_tween()
	tween.tween_property($Name, "modulate", Color(1.0, 1.0, 1.0, 1.0), 0.3)
	$Tooltip.update()
	$Tooltip.visible = true


func _on_Area2D_mouse_exited() -> void:
	var tween = create_tween()
	tween.tween_property($Name, "modulate", Color(1.0, 1.0, 1.0, 0.0), 0.3)
	$Tooltip.visible = false
