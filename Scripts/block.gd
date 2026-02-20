extends CharacterBody2D

var can_drag = false
var drag_offset = Vector2(0,0)
var integrity = 0
var force = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if can_drag:
		var current_position = global_position
		var distance = global_position.distance_to(get_global_mouse_position())
		var direction = global_position.direction_to(get_global_mouse_position())
		
		var speed = distance / delta
		velocity = direction * speed
		move_and_slide()

func _on_button_button_down() -> void:
	drag_offset = get_global_mouse_position() - global_position
	can_drag = true

func _on_button_button_up() -> void:
	can_drag = false
