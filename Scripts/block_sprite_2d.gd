extends Sprite2D

@onready var forward_lerping: bool = false
@onready var reverse_lerping: bool = false
@onready var t: float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


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
	

func _on_button_button_down() -> void:
	forward_lerping = true
	reverse_lerping = false
	t = 0.0


func _on_button_button_up() -> void:
	forward_lerping = false
	reverse_lerping = true
	t = 0.0
