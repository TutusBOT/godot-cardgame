extends Node2D

class_name Player

var Torment = preload("res://src/Effect/Effects/Torment.tscn")

var health: int
var max_health: int
var max_sanity: int = 10
var sanity: int = 10
var effects: = []
var block: = 0
var absorption: = 0

func init(hp: int):
	max_health = hp
	health = max_health
	$HealthBar.max_value = max_health
	update_health_UI()

func damage(amount: int):
	print("amoutnt of dmg ", amount, " block ", block)
	if block > 0:
		if block >= amount:
			remove_block(amount)
			amount = 0
		else:
			amount -= block
			remove_block(block)
	var damage = amount - absorption
	print(damage, "player damaged for ", block, " block")
	print(block)
	if damage > 0:
		health -= damage
	if health < 1:
		health = 0
		die()
	update_health_UI()
		
func heal(amount: int):
	health += amount
	if health > max_health:
		health = max_health
	update_health_UI()
	
func die():
	if GameState.Vivere.uses > 0:
		GameState.Vivere.use()
	else:
		print('u ded')
		

func update_health_UI():
	print('1', health, max_health)
	$Health.text = str(health, "/", max_health)
	$HealthBar.value = health
	
func set_sanity(value: int):
	sanity = value
	$SanityBar.value = sanity
	if sanity < 1:
		var torment = Torment.instance()
		torment.init(-1, self)
	
func get_sanity():
	return sanity

func set_damage_modifier(value: float):
	GameState.setPlayerDamageModifier(value)

func add_block(amount: int):
	block += amount
	$Block.text = str(block)
	$Block.visible = true
	print(block)

func remove_block(amount: int):
	block -= amount
	$Block.text = str(block)
	if block < 1:
		block = 0
		$Block.visible = false
	print(block)


func _on_Area2D_mouse_entered() -> void:
	$Tooltip.update()
	$Tooltip.visible = true


func _on_Area2D_mouse_exited() -> void:
	$Tooltip.visible = false
