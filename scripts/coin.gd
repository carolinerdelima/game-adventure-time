extends Area2D
@onready var manager: Node = %Manager
@onready var anim = $AnimationPlayer
func _on_body_entered(body: Node2D) -> void:
	manager.add_point()
	anim.play("pickup")
