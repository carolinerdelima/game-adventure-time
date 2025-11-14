extends Node

var score = 0
@onready var hud_label: Label = $"/root/Node2D/HUD/Control/CoinLabel"

func add_point():
	score += 1
	hud_label.text = "Moedas: %d" % score
	print(score)
