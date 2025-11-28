extends Node2D

@onready var background: Sprite2D = $Background

func _ready() -> void:
    background.input_pickable = false
    _resize_background()
    get_viewport().size_changed.connect(_resize_background)

func _resize_background() -> void:
    if background.texture == null:
        return

    var viewport_size: Vector2 = get_viewport_rect().size
    var texture_size: Vector2 = background.texture.get_size()
    if texture_size == Vector2.ZERO:
        return

    var scale_factor: Vector2 = Vector2(
        viewport_size.x / texture_size.x,
        viewport_size.y / texture_size.y
    )

    var uniform_scale: float = max(scale_factor.x, scale_factor.y)
    background.scale = Vector2.ONE * uniform_scale
    background.position = Vector2.ZERO

func _on_start_pressed() -> void:
    get_tree().change_scene_to_file("res://scenes/node_2d.tscn")

func _on_quit_pressed() -> void:
    get_tree().quit()
