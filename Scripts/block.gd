extends CharacterBody2D
class_name Block

@onready var can_drag = false
@onready var can_update = true

@onready var drag_offset = Vector2(0,0)

@onready var integrity: int = 0
@onready var max_neighbour_integrity = 0

@export var neighbour_area2d: Area2D
@export var parent_body2d: CharacterBody2D
@export var integrity_text: TextEdit
@export var sprite2D: Sprite2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D

@onready var neighbour_manager: Node = $"../../NeighbourManager"

func _physics_process(delta: float) -> void:
	if !can_drag: return
	
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
	if can_update:
		neighbour_manager.check_integrity(self)


func _on_confirmation_button_button_down() -> void:
	if await neighbour_manager.check_integrity(self):
		neighbour_manager.new_neighbour(self)
	can_update = false
