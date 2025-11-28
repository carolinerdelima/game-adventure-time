extends Node

var score = 0
@onready var hud_label: Label = $"../HUD/CoinLabel"
func add_point():
	score += 1
	hud_label.text = "Moedas: %d" % score
	print(score)


func _on_RetryButton_pressed() -> void:
	pass # Replace with function body.
