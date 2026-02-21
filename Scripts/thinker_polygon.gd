extends Area2D

var top_left: Vector2 = Vector2(453, 176)
var bottom_right: Vector2 = Vector2(703, 528)
var bounding_box: Rect2 = Rect2(top_left.x, top_left.y, bottom_right.x-top_left.x, bottom_right.y-top_left.y)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _draw() -> void:
	draw_rect(bounding_box, Color.GREEN, false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
