extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_mouse_entered() -> void:
	if not get_parent().get_parent().get_parent().object_has_arrived:
		print("not arrived enter")
		return
	Input.set_custom_mouse_cursor(load("res://Assets/cursors/hand_small_open_cropped.png"))


func _on_mouse_exited() -> void:
	if not get_parent().get_parent().get_parent().object_has_arrived:
		print("not arrived enter")
		return
	Input.set_custom_mouse_cursor(load("res://Assets/cursors/hand_small_point_cropped.png"))
