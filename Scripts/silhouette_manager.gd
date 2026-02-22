extends Control

@export var finish_button: Button
@export var objects_list: Node
@export var ray: RayCast2D
@export var level_pass_panel:Panel

@export var levels:Array[TextureRect]

@onready var current_level_idx: int = 0

var final_top_left
var final_bottom_right

var construct_bounding_box: Rect2
var final_bounding_box: Rect2

signal level_resetted

func _ready() -> void:
	load_level()

func _draw() -> void:
	draw_rect(construct_bounding_box, Color.RED, false)
	draw_rect(final_bounding_box, Color.GREEN, false)
	
func check_score() -> void:
	var polygon2d: Area2D = levels[current_level_idx].get_child(0)
	
	var construct_top_left: Vector2 = Vector2.INF
	var construct_bottom_right: Vector2 = Vector2.ZERO
	for child: Block in objects_list.get_children():
		if child.can_update or child.position == Vector2(2000, 2000): continue
		construct_top_left.x = min(child.global_position.x - child.collision_shape.shape.size.x/2, construct_top_left.x)
		construct_top_left.y = min(child.global_position.y - child.collision_shape.shape.size.y/2, construct_top_left.y)
		construct_bottom_right.x = max(child.global_position.x + child.collision_shape.shape.size.x/2, construct_bottom_right.x)
		construct_bottom_right.y = max(child.global_position.y + child.collision_shape.shape.size.y/2, construct_bottom_right.y)
	
	construct_bounding_box = Rect2(construct_top_left, construct_bottom_right-construct_top_left)
	final_top_left = Vector2(min(construct_top_left.x, polygon2d.top_left.x), min(construct_top_left.y, polygon2d.top_left.y))
	final_bottom_right = Vector2(max(construct_bottom_right.x, polygon2d.bottom_right.x), max(construct_bottom_right.y, polygon2d.bottom_right.y))
	#final_top_left = polygon2d.top_left
	#final_bottom_right = polygon2d.bottom_right
	
	final_bounding_box = Rect2(final_top_left, final_bottom_right-final_top_left)
	#polygon2d.queue_redraw()
	#queue_redraw()
	
	
	var score: int = 0
	var max_score: int = 1000
	var outlier: int = 0
	for i in max_score:
		var test_point: Vector2 = Vector2(randi_range(final_top_left.x, final_bottom_right.x), randi_range(final_top_left.y, final_bottom_right.y))
		ray.global_position = test_point
		ray.target_position = Vector2.ZERO
		ray.force_raycast_update()
		if test_point.x < polygon2d.top_left.x or test_point.x > polygon2d.bottom_right.x or test_point.y < polygon2d.top_left.y or test_point.y > polygon2d.bottom_right.y:
			continue
		var offset = polygon2d.global_position
		var global_polygon_coords:PackedVector2Array
		for vec in polygon2d.get_child(0).get_polygon():
			global_polygon_coords.append(vec+offset)
		if ray.is_colliding() and Geometry2D.is_point_in_polygon(test_point, global_polygon_coords):
			score += 1
		elif not ray.is_colliding() and not Geometry2D.is_point_in_polygon(test_point, global_polygon_coords):
			outlier += 1
			
	var final_score: int = int(float(score)/float(max_score-outlier) * 100)
	level_pass_panel.get_node("Label").text = "You got " + str(final_score) + "%\nNice job! How to you want to continue?"
	
	finish_level()
	
func finish_level() -> void:
	level_pass_panel.visible = true

func load_level() -> void:
	level_pass_panel.visible = false
	level_resetted.emit()
	levels[current_level_idx].process_mode = Node.PROCESS_MODE_INHERIT
	levels[current_level_idx].visible = true

func _on_finish_button_button_down() -> void:
	check_score()

func _on_replay_button_down() -> void:
	load_level()

func _on_next_level_button_down() -> void:
	levels[current_level_idx].process_mode = Node.PROCESS_MODE_DISABLED
	levels[current_level_idx].visible = false
	current_level_idx += 1
	load_level()
