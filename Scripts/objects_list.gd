extends Node

@export var audio_streams:Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_child_entered_tree(node: Block) -> void:
	await node.ready
	node.block_placed.connect(_on_block_placed)
	node.block_missed.connect(_on_block_missed)
	node.drag_button.button_down.connect(_on_block_pickedup)
	node.neighbour_entered.connect(_on_neighbour_entered)
	
func _on_block_placed() -> void:
	print("placed")
	audio_streams.get_node("Success").play()
	
func _on_block_missed() -> void:
	audio_streams.get_node("Fail").play()

func _on_block_pickedup() -> void:
	pass
	#audio_streams.get_node("Pickup").play()

func _on_neighbour_entered(integrity: int) -> void:
	audio_streams.get_node("Contact").play()
