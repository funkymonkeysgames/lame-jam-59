extends Panel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_node("Button").button_down.connect(_on_button_down)

func _on_button_down() -> void:
	visible = false


func _on_tutorial_2_visibility_changed() -> void:
	visible = false


func _on_tutorial_3_visibility_changed() -> void:
	visible = false


func _on_tutorial_4_visibility_changed() -> void:
	visible = false
