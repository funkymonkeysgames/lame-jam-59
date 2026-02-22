extends Sprite2D

@onready var forward_lerping: bool = false
@onready var reverse_lerping: bool = false
@onready var t: float = 0.0

@onready var animation_player:AnimationPlayer = $AnimationPlayer
@onready var particles:CPUParticles2D = $CPUParticles2D
@onready var shader_timer: Timer = $IntegrityShaderTimer

var angle_x_max: float = 15.0
var angle_y_max: float = 15.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var object:Block = get_parent()
	object.block_placed.connect(_on_character_body_2d_block_placed)
	object.block_missed.connect(_on_character_body_2d_block_missed)
	object.neighbour_entered.connect(_on_character_body_2d_neighbour_entered)
	shader_timer.timeout.connect(_on_integrity_shader_timer_timeout)
	material.set("shader_parameter/tint_factor", 0.0)
	material.resource_local_to_scene = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if forward_lerping:
		scale = scale.lerp(Vector2(1.3, 1.3), t)
		t += delta * 5.0
		
		if t >= 1.0:
			forward_lerping = false
			t = 0.0
	elif reverse_lerping:
		scale = scale.lerp(Vector2(1.0, 1.0), t)
		t += delta * 5.0
		
		if t >= 1.0:
			reverse_lerping = false
			t = 0.0

func _on_character_body_2d_block_placed() -> void:
	particles.emitting = true
	
func _on_character_body_2d_block_missed() -> void:
	animation_player.play("shake")

func _on_character_body_2d_neighbour_entered(integrity: int) -> void:
	print(get_parent().can_update)
	if not get_parent().can_update: return
	shader_timer.start()
	if integrity == 0:
		material.set("shader_parameter/colour", Color(3.852, 0.628, 0.628))
	elif integrity == 1:
		material.set("shader_parameter/colour", Color(3.852, 2.182, 0.628))
	elif integrity == 2:
		material.set("shader_parameter/colour", Color(3.852, 3.213, 0.628))
	elif integrity == 3:
		material.set("shader_parameter/colour", Color(4.006, 4.006, 0.655))
	elif integrity == 4:
		material.set("shader_parameter/colour", Color(2.747, 3.294, 0.53))
	elif integrity == 5:
		material.set("shader_parameter/colour", Color(0.894, 4.0, 0.452))
	material.set("shader_parameter/tint_factor", 0.4)
	
func _on_integrity_shader_timer_timeout() -> void:
	material.set("shader_parameter/tint_factor", 0.0)

func _on_button_button_down() -> void:
	forward_lerping = true
	reverse_lerping = false
	t = 0.0

func _on_button_button_up() -> void:
	forward_lerping = false
	reverse_lerping = true
	t = 0.0
