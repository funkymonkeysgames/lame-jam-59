extends Node2D

var rng = RandomNumberGenerator.new()

var possible_objects = []

var water_bottle_scene = preload("res://Scenes/Objects/water_bottle.tscn")
var bigger_tin_can_scene = preload("res://Scenes/Objects/bigger_tin_can.tscn")
var box_scene = preload("res://Scenes/Objects/box.tscn")
var coke_bottle_scene = preload("res://Scenes/Objects/coke_bottle.tscn")
var detergent_scene = preload("res://Scenes/Objects/detergent.tscn")
var mug_scene = preload("res://Scenes/Objects/mug.tscn")
var newspaper_scene = preload("res://Scenes/Objects/newspaper.tscn")
var paper_bag_scene = preload("res://Scenes/Objects/paper_bag.tscn")
var pizza_box_scene = preload("res://Scenes/Objects/pizza_box.tscn")
var soda_can_scene = preload("res://Scenes/Objects/soda_can.tscn")
var spray_can_scene = preload("res://Scenes/Objects/spray_can.tscn")
var styro_cup_scene = preload("res://Scenes/Objects/styro_cup.tscn")
var currentObject: Node = null
var nextObject: Node = null
@export var nextObjectPreview:Sprite2D
@export var objects_list: Node

var object_has_arrived = true
var start_position: Vector2
var start_scale: Vector2
var t: float = 0
var targetPosition: Vector2 = Vector2(574, 83)
var objectTaken: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	initilizeSceneArray()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:

	if nextObject == null:
		setObjects()

	if t >= 1:
		object_has_arrived = true
		t = 0
		nextObjectPreview.global_rotation = 0
		nextObjectPreview.scale = Vector2(1.0, 1.0)

	if !object_has_arrived:
		t += delta * 0.4
		nextObjectPreview.global_position = start_position.lerp(targetPosition, t)
		nextObjectPreview.scale = start_scale.lerp(Vector2(1.0, 1.0), t)

		nextObjectPreview.rotation += 15 * delta

func pickRandomObject() -> PackedScene:
	return possible_objects.pick_random()

func initilizeSceneArray() -> void:
	possible_objects.append(water_bottle_scene)
	possible_objects.append(bigger_tin_can_scene)
	possible_objects.append(box_scene)
	possible_objects.append(coke_bottle_scene)
	possible_objects.append(detergent_scene)
	possible_objects.append(mug_scene)
	possible_objects.append(newspaper_scene)
	possible_objects.append(paper_bag_scene)
	possible_objects.append(pizza_box_scene)
	possible_objects.append(soda_can_scene)
	possible_objects.append(spray_can_scene)
	possible_objects.append(styro_cup_scene)

func setObjects():
	nextObject = pickRandomObject().instantiate()
	nextObject.can_update = false
	objects_list.add_child(nextObject)
	nextObject.global_position = Vector2(2000, 2000)
	nextObjectPreview.texture
	nextObject.sprite2D.texture
	nextObjectPreview.texture = nextObject.sprite2D.texture
	nextObjectPreview.global_position = targetPosition


func _on_button_button_down() -> void:
	if object_has_arrived and (currentObject == null or !currentObject.can_update):
		nextObjectPreview.global_position = Vector2(2000, 2000)

		currentObject = nextObject
		currentObject.global_position = targetPosition
		objectTaken = true
		currentObject.can_update = true
		currentObject.find_child("Sprite2D").find_child("Button").button_down.emit()
		Input.set_custom_mouse_cursor(load("res://Assets/cursors/hand_small_closed_cropped.png"))
		
		nextObject = pickRandomObject().instantiate()
		nextObject.can_update = false
		objects_list.add_child(nextObject)
		nextObject.global_position = Vector2(2000, 2000)
		nextObjectPreview.texture = nextObject.sprite2D.texture

		throw_next_object()

func throw_next_object() -> void:
	var spawn_x: float = 0
	if randi() % 2:
		spawn_x = -10
	else:
		spawn_x = 1162

	var spawn_y:float = rng.randf_range(0, 200)
	start_position = Vector2(spawn_x, spawn_y)
	start_scale = Vector2(0.2, 0.2)
	nextObjectPreview.global_position = start_position
	nextObjectPreview.scale = start_scale
	object_has_arrived = false


func _on_button_button_up() -> void:
	if objectTaken:
		currentObject.find_child("Sprite2D").find_child("Button").button_up.emit()
		objectTaken = false
