extends TextureButton

func _ready() -> void:
	connect_signals()
	
func connect_signals() -> void:
	# to change the cursor on hover
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	# to receive valid placement confirmation
	get_parent().block_placed.connect(_on_character_body_2d_block_placed)
	# to remove confirmation buttonw while being dragged
	var drag_button: Button = $"../Sprite2D/Button"	
	drag_button.button_down.connect(_on_button_button_down)
	drag_button.button_up.connect(_on_button_button_up)

func _on_button_button_down() -> void:
	visible = false

func _on_button_button_up() -> void:
	visible = true

func _on_mouse_entered() -> void:
	Input.set_custom_mouse_cursor(load("res://Assets/cursors/hand_point.svg"))

func _on_mouse_exited() -> void:
	Input.set_custom_mouse_cursor(load("res://Assets/cursors/hand_open.svg"))

func _on_character_body_2d_block_placed() -> void:
	visible = false
	disabled = true
