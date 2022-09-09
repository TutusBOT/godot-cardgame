extends Node

var DrawPile: Array
var Hand: Array
var DiscardPile: Array
var Deck: Array

var Energy: int = 3
var MaxEnergy: int = 3
signal energy_updated

var Battle: Node2D
var Enemies: Array
var Player: Node2D
var PlayerDamageModifier:= 1.0
signal damage_modifier_updated

var Map: Node2D

var Vivere: TextureButton

func getEnergy():
	return Energy
	
func setEnergy(value: int):
	Energy = value
	get_node("/root/Root/Battle/PlaySpace/EnergyCounter/Label").text = str(value)
	emit_signal("energy_updated")

func resetEnergy():
	Energy = MaxEnergy
	get_node("/root/Root/Battle/PlaySpace/EnergyCounter/Label").text = str(Energy)
	emit_signal("energy_updated")	

func setPlayerDamageModifier(value: float):
	PlayerDamageModifier = value
	emit_signal("damage_modifier_updated")
