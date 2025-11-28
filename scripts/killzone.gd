extends Area2D

var game_over_layer: CanvasLayer

func _ready() -> void:
    var current_scene := get_tree().current_scene
    if current_scene.has_node("GameOverLayer"):
        game_over_layer = current_scene.get_node("GameOverLayer")

func _on_body_entered(body: Node2D) -> void:
    if body.has_method("is_attack_active") and body.is_attack_active():
        var enemy := _find_enemy_owner()
        if enemy and enemy.has_method("take_damage"):
            enemy.take_damage()
        return

    print("Você morreu")

    if body.has_method("death"):
        body.death()

    if game_over_layer:
        game_over_layer.visible = true

    get_tree().paused = true

func _find_enemy_owner() -> Node:
    var current: Node = self
    while current:
        if current.has_method("take_damage"):
            return current
        current = current.get_parent()
    return null
