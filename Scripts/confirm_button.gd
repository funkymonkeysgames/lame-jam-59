extends TextureButton

func _on_button_button_down() -> void:
	visible = false


func _on_button_button_up() -> void:
	visible = true


func _on_button_down() -> void:
	visible = false
	disabled = true
