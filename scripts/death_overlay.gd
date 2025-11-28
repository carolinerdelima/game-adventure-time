extends CanvasLayer

@onready var dimmer: ColorRect = $Dimmer
@onready var banner: TextureRect = $Banner
@onready var label: Label = $Banner/Label

func show_banner() -> void:
    visible = true
    dimmer.mouse_filter = Control.MOUSE_FILTER_STOP
    banner.mouse_filter = Control.MOUSE_FILTER_STOP

func hide_banner() -> void:
    visible = false

func set_banner_texture(texture: Texture2D) -> void:
    banner.texture = texture
    label.visible = texture == null