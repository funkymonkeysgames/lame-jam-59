extends Node2D

var rng = RandomNumberGenerator.new()

var move_distance:int = 3
var move_count:int = 0
var move_direction: int = 1

@export var anim_timer:Timer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_timer_timeout():
	if (move_count > -3 and move_direction == -1):
		move_distance = -3
		move_count = move_count - 1

	elif (move_count < 3 and move_direction == 1):
		move_distance = 3
		move_count = move_count + 1

	else:
		move_direction *= -1

	position = position + Vector2(move_distance, move_distance/3)
	pick_random_time()

func pick_random_time():
	anim_timer.set_wait_time(rng.randf_range(1.5, 2.4))
