extends Node2D

var can_drag = false
var drag_offset = Vector2(0,0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if can_drag:
		global_position = get_global_mouse_position() - drag_offset

func _on_button_button_down() -> void:
	drag_offset = get_global_mouse_position() - global_position
	can_drag = true

func _on_button_button_up() -> void:
	can_drag = false
