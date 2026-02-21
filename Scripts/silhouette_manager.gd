extends Control

@export var finish_button: Button
@export var objects_list: Node
@export var ray: RayCast2D

@onready var silhouettes: Array = []
@onready var polygons: Array = []

@onready var silhouette_texturerect: TextureRect = $SilhouetteTextureRect

var construct_bounding_box: Rect2
var final_bounding_box: Rect2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	silhouettes.append(load("res://Assets/Silhouettes/thinker_cropped_silhouette_transparent.png"))
	polygons.append(preload("res://Scenes/Silhouettes/thinker_polygon.tscn"))
	
	silhouette_texturerect.texture = silhouettes[0]#randi_range(0, silhouettes.size())]

func _draw() -> void:
	draw_rect(construct_bounding_box, Color.GREEN, false)
	draw_rect(final_bounding_box, Color.GREEN, false)
	
func check_score() -> void:
	var polygon2d: Area2D = polygons[0].instantiate()
	polygon2d.global_position = Vector2.ZERO
	
	add_child(polygon2d)
	var construct_top_left: Vector2 = Vector2.INF
	var construct_bottom_right: Vector2 = Vector2.ZERO
	for child: Block in objects_list.get_children():
		if child.can_update: continue
		construct_top_left.x = min(child.global_position.x - child.collision_shape.shape.size.x/2, construct_top_left.x)
		construct_top_left.y = min(child.global_position.y - child.collision_shape.shape.size.y/2, construct_top_left.y)
		construct_bottom_right.x = max(child.global_position.x + child.collision_shape.shape.size.x/2, construct_bottom_right.x)
		construct_bottom_right.y = max(child.global_position.y + child.collision_shape.shape.size.y/2, construct_bottom_right.y)
	
	construct_bounding_box = Rect2(construct_top_left, construct_bottom_right-construct_top_left)
	var final_top_left = Vector2(min(construct_top_left.x, polygon2d.top_left.x), min(construct_top_left.y, polygon2d.top_left.y))
	var final_bottom_right = Vector2(max(construct_bottom_right.x, polygon2d.bottom_right.x), max(construct_bottom_right.y, polygon2d.bottom_right.y))
	final_bounding_box = Rect2(final_top_left, final_bottom_right-final_top_left)
	polygon2d.queue_redraw()
	
	
	var score: int = 0
	var max_score: int = 1000
	var outlier: int = 0
	for i in max_score:
		var test_point: Vector2 = Vector2(randi_range(final_top_left.x, final_bottom_right.x), randi_range(final_top_left.y, final_bottom_right.y))
		ray.position = test_point
		ray.target_position = Vector2.ZERO
		ray.force_raycast_update()
		if test_point.x < polygon2d.top_left.x or test_point.x > polygon2d.bottom_right.x or test_point.y < polygon2d.top_left.y or test_point.y > polygon2d.bottom_right.y:
			continue
		if ray.is_colliding() and Geometry2D.is_point_in_polygon(test_point, polygon2d.get_child(0).get_polygon()):
			score += 1
		elif not ray.is_colliding() and not Geometry2D.is_point_in_polygon(test_point, polygon2d.get_child(0).get_polygon()):
			outlier += 1
			
	print(float(score)/float(max_score-outlier))
		

func _on_finish_button_button_down() -> void:
	check_score()
	silhouette_texturerect.texture = silhouettes[randi_range(0, silhouettes.size()-1)]
