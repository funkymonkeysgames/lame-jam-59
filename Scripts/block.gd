extends CharacterBody2D

var can_drag = false
var drag_offset = Vector2(0,0)

var integrity: int

@onready var neighbour_area2d: Area2D = $Neighbour
@onready var parent_body2d = $".."
@onready var integrity_text: TextEdit = $IntegrityText


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	integrity = 0

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


func _on_neighbor_area_entered(area: Area2D) -> void:
	var max_neighbour_integrity = 0
	for neighbour: Area2D in neighbour_area2d.get_overlapping_areas():
		max_neighbour_integrity = max(max_neighbour_integrity, neighbour.get_parent().integrity)
	integrity = max_neighbour_integrity - 1
	integrity_text.text = str(integrity)
