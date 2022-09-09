extends Node

var Cards = {
	"Strike": {
		"name": "Strike",
		"cost": 1,
		"description": "Deals 5 damage.",
		"target": "single",
		"effect": "damage"
	},
	"Defend": {
		"name": "Defend",
		"cost": 1,
		"description": "Block 5 damage",
		"target": "self",
		"effect": "block"
	}
}

func damage_enemy(target: Node2D, amount: int):
	target.damage(amount)
	
