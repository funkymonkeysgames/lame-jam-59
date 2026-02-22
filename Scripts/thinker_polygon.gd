extends Area2D

@onready var top_left: Vector2 = Vector2.INF
@onready var bottom_right: Vector2 = Vector2.ZERO
@onready var bounding_box: Rect2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for p:CollisionPolygon2D in get_children():
		var offset = p.global_position
		
		for v:Vector2 in p.polygon:
			top_left.x = min(top_left.x, v.x + offset.x)
			top_left.y = min(top_left.y, v.y + offset.y)
			bottom_right.x = max(bottom_right.x, v.x + offset.x)
			bottom_right.y = max(bottom_right.y, v.y + offset.y)
	
	bounding_box = Rect2(top_left.x, top_left.y, bottom_right.x-top_left.x, bottom_right.y-top_left.y)
#
#func _draw() -> void:
	#draw_rect(bounding_box, Color.BLUE, false)
