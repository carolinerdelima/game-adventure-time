extends CanvasLayer

func _ready() -> void:
	# Faz este CanvasLayer (e os filhos, incluindo o botão)
	# continuarem funcionando mesmo com o jogo pausado
	process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	# (Se der erro, pode usar Node.PROCESS_MODE_ALWAYS também)

func _on_RetryButton_pressed() -> void:
	print("BOTÃO CLICADO — recarregando cena...")
	get_tree().paused = false
	get_tree().reload_current_scene()
