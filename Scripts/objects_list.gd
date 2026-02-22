extends Node2D

@export var audio_streams:Node

signal mouse_approached

func _on_child_entered_tree(node: Block) -> void:
	await node.ready
	node.block_placed.connect(_on_block_placed)
	node.block_missed.connect(_on_block_missed)
	node.drag_button.button_down.connect(_on_block_pickedup)
	node.neighbour_entered.connect(_on_neighbour_entered)
	mouse_approached.connect(node.get_node("Sprite2D")._on_mouse_approached)
	
func _on_block_placed() -> void:
	print("placed")
	audio_streams.get_node("Success").play()
	
func _on_block_missed() -> void:
	audio_streams.get_node("Fail").play()

func _on_block_pickedup() -> void:
	audio_streams.get_node("Pickup").play()

func _on_neighbour_entered(integrity: int) -> void:
	audio_streams.get_node("Contact").play()

func _on_result_button_button_down() -> void:
	audio_streams.get_node("Click").play()
