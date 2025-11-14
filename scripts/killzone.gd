extends Area2D

@onready var timer: Timer = $Timer

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("is_attack_active") and body.is_attack_active():
		var enemy := _find_enemy_owner()
		if enemy and enemy.has_method("take_damage"):
			enemy.take_damage()
		return
	print("Você morreu")
	Engine.time_scale = 0.5
	body.get_node("CollisionShape2D").queue_free()
	timer.start()

func _find_enemy_owner() -> Node:
	var current: Node = self
	while current:
		if current.has_method("take_damage"):
			return current
		current = current.get_parent()
	return null

func _on_timer_timeout() -> void:
	Engine.time_scale = 1.0
	get_tree().reload_current_scene()
