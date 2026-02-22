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
@onready var sprite2D: Sprite2D = $Sprite2D

@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var drag_button: Button = $Sprite2D/Button
@onready var confirmation_button: TextureButton = $ConfirmationButton
@onready var neighbour_manager: Node = $"../../NeighbourManager"

@onready var t: float = 0.0
@onready var lerping: bool = false
@onready var target_rotation: float = 0.0

@onready var has_neighbour: bool = false

signal block_placed
signal block_missed
signal neighbour_entered

func _ready() -> void:
	# drag button
	drag_button.button_down.connect(_on_button_button_down)
	drag_button.button_up.connect(_on_button_button_up)
	# confirmation button
	confirmation_button.button_down.connect(_on_confirmation_button_button_down)
	# neighbour area
	neighbour_area2d.area_exited.connect(_on_neighbor_area_exited)
	# hover cursor
	drag_button.mouse_entered.connect(_on_hover)
	drag_button.mouse_exited.connect(_on_hover_exit)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("rotate_clockwise_90"):
		target_rotation += 90
		lerping = true
		t = 0.0
	elif Input.is_action_just_pressed("rotate_counterclockwise_90"):
		target_rotation -= 90
		lerping = true
		t = 0.0
	elif Input.is_action_just_pressed("rotate_clockwise_45"):
		target_rotation += 45
		lerping = true
		t = 0.0
	elif Input.is_action_just_pressed("rotate_counterclockwise_45"):
		target_rotation -= 45
		lerping = true
		t = 0.0

func _physics_process(delta: float) -> void:
	if lerping and can_update:
		collision_shape.rotation_degrees = lerpf(collision_shape.rotation_degrees, target_rotation, t)
		neighbour_area2d.rotation_degrees = lerpf(neighbour_area2d.rotation_degrees, target_rotation, t)
		sprite2D.rotation_degrees = lerpf(sprite2D.rotation_degrees, target_rotation, t)
		t += delta * 100.0
		
		if t >= 1.0:
			lerping = false
			t = 0.0
			
	if !can_drag: return
	
	var distance = global_position.distance_to(get_global_mouse_position())
	if has_neighbour and distance > 20:
		drag_button.button_up.emit()
		
	var direction = global_position.direction_to(get_global_mouse_position())
	
	var speed = distance / delta
	velocity = direction * speed
	move_and_slide()
	
func _on_hover() -> void:
	if not can_update: return
	Input.set_custom_mouse_cursor(load("res://Assets/cursors/hand_small_open_cropped.png"))
	
func _on_hover_exit() -> void:
	if not can_update: return
	Input.set_custom_mouse_cursor(load("res://Assets/cursors/hand_small_point_cropped.png"))

func _on_button_button_down() -> void:
	Input.set_custom_mouse_cursor(load("res://Assets/cursors/hand_small_closed_cropped.png"))
	drag_offset = get_global_mouse_position() - global_position
	can_drag = true

func _on_button_button_up() -> void:
	Input.set_custom_mouse_cursor(load("res://Assets/cursors/hand_small_point_cropped.png"))
	can_drag = false
	
func _on_neighbor_area_entered(_area: Area2D) -> void:
	has_neighbour = true
	if can_update:
		await neighbour_manager.check_integrity(self)
		neighbour_entered.emit(integrity)

func _on_neighbor_area_exited(_area: Area2D) -> void:
	has_neighbour = false
	if can_update:
		await neighbour_manager.check_integrity(self)

func _on_confirmation_button_button_down() -> void:
	if await neighbour_manager.check_integrity(self):
		neighbour_manager.new_neighbour(self)
		can_update = false
		block_placed.emit()
	else:
		block_missed.emit()
	
