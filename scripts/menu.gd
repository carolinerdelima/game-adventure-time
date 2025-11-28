extends Node2D

@onready var background: Sprite2D = $Background

func _ready() -> void:
    _resize_background()
    get_viewport().size_changed.connect(_resize_background)

func _resize_background() -> void:
    if background.texture == null:
        return

    var viewport_size := get_viewport_rect().size
    var texture_size := background.texture.get_size()
    if texture_size == Vector2.ZERO:
        return

    var scale_factor := Vector2(
        viewport_size.x / texture_size.x,
        viewport_size.y / texture_size.y,
    )
    var uniform_scale := max(scale_factor.x, scale_factor.y)
    background.scale = Vector2.ONE * uniform_scale
    background.position = viewport_size * 0.5

func _on_start_pressed() -> void:
    get_tree().change_scene_to_file("res://scenes/node_2d.tscn")

func _on_quit_pressed() -> void:
    get_tree().quit()
