extends Button

func _ready() -> void:
	var object_root:Block = $"../.."
	object_root.block_placed.connect(_on_character_body_2d_block_placed)
	
func _on_character_body_2d_block_placed() -> void:
	disabled = true
