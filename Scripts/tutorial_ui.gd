extends Control

@onready var first_item_grabbed: bool = false
@onready var first_item_connected: bool = false
@onready var first_item_placed: bool = false
@onready var first_level_beat: bool = false



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_parent().get_node("TetrisSpawner").get_child(0).get_child(0).get_child(0).button_down.connect(_on_item_grabbed)
	get_parent().get_node("SilhouetteManager").get_node("Panel").get_node("Next level").button_down.connect(_on_first_level_pass)
	
	
	
func _on_start_button_button_down() -> void:
	get_node("Tutorial1").visible = true

func _on_item_grabbed() -> void:
	if not first_item_grabbed:
		first_item_grabbed = true
		get_node("Tutorial2").visible = true

func _on_block_placed() -> void:
	if not first_item_placed:
		first_item_placed = true
		get_node("Tutorial3").visible = true
		
func _on_first_level_pass() -> void:
	if not first_level_beat:
		first_level_beat = true
		get_node("Tutorial4").visible = true


func _on_objects_list_child_entered_tree(node: Node) -> void:
	if not first_item_connected:
		print("connecting")
		first_item_connected = true
		var object:Block = get_parent().get_node("ObjectsList").get_child(0)
		await object.ready
		object.block_placed.connect(_on_block_placed)
