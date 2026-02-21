extends Node2D


var possible_objects = []

var water_bottle_scene = preload("res://Scenes/Objects/water_bottle.tscn")
var bigger_tin_can_scene = preload("res://Scenes/Objects/bigger_tin_can.tscn")
var box_scene = preload("res://Scenes/Objects/box.tscn")
var coke_bottle_scene = preload("res://Scenes/Objects/coke_bottle.tscn")
var detergent_scene = preload("res://Scenes/Objects/detergent.tscn")
var detergent2_scene = preload("res://Scenes/Objects/detergent2.tscn")
var glass_bottle_scene = preload("res://Scenes/Objects/glass_bottle.tscn")
var jar_scene = preload("res://Scenes/Objects/jar.tscn")
var mug_scene = preload("res://Scenes/Objects/mug.tscn")
var newspaper_scene = preload("res://Scenes/Objects/newspaper.tscn")
var paper_bag_scene = preload("res://Scenes/Objects/paper_bag.tscn")
var pizza_box_scene = preload("res://Scenes/Objects/pizza_box.tscn")
var soda_can_scene = preload("res://Scenes/Objects/soda_can.tscn")
var spray_can_scene = preload("res://Scenes/Objects/spray_can.tscn")
var styro_cup_scene = preload("res://Scenes/Objects/styro_cup.tscn")
var tin_can_scene = preload("res://Scenes/Objects/tin_can.tscn")

var currentObject: Node = null
var nextObject: Node = null
@export var nextObjectPreview:Sprite2D
@export var objects_list: Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	initilizeSceneArray()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if currentObject == null or !currentObject.can_update:
		setObjects()

func pickRandomObject() -> PackedScene:
	return possible_objects.pick_random()

func initilizeSceneArray() -> void:
	possible_objects.append(water_bottle_scene)
	possible_objects.append(bigger_tin_can_scene)
	possible_objects.append(box_scene)
	possible_objects.append(coke_bottle_scene)
	possible_objects.append(detergent_scene)
	possible_objects.append(detergent2_scene)
	possible_objects.append(glass_bottle_scene)
	possible_objects.append(jar_scene)
	possible_objects.append(mug_scene)
	possible_objects.append(newspaper_scene)
	possible_objects.append(paper_bag_scene)
	possible_objects.append(pizza_box_scene)
	possible_objects.append(soda_can_scene)
	possible_objects.append(spray_can_scene)
	possible_objects.append(styro_cup_scene)
	possible_objects.append(tin_can_scene)

func setObjects():
	if nextObject == null:
		currentObject = pickRandomObject().instantiate()
		objects_list.add_child(currentObject)
	else:
		currentObject = nextObject
	currentObject.global_position = Vector2(100, 100)
	nextObject = pickRandomObject().instantiate()
	objects_list.add_child(nextObject)
	nextObject.global_position = Vector2(2000, 2000)
	nextObjectPreview.texture
	nextObject.sprite2D.texture
	nextObjectPreview.texture = nextObject.sprite2D.texture
