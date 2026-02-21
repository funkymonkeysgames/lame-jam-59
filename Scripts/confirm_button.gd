extends TextureButton

func _ready() -> void:
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)

func _on_button_button_down() -> void:
	visible = false

func _on_button_button_up() -> void:
	visible = true

func _on_button_down() -> void:
	visible = false
	disabled = true

func _on_mouse_entered() -> void:
	Input.set_custom_mouse_cursor(load("res://Assets/cursors/hand_point.svg"))

func _on_mouse_exited() -> void:
	Input.set_custom_mouse_cursor(load("res://Assets/cursors/hand_open.svg"))
