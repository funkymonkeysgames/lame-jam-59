extends Node

@export var title_screen: Control
@export var floor: StaticBody2D
@export var background: Node2D
@export var music_player: AudioStreamPlayer
@export var ui2: Control
@export var silhouettemanager: Control
@export var tetris_spawner: Node2D
@export var objects_list: Node2D
@export var button: Button
@export var sfx: Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_button_button_down() -> void:
	title_screen.visible = false
	title_screen.process_mode = Node.PROCESS_MODE_DISABLED
	floor.visible = true
	background.visible = true
	ui2.visible = true
	silhouettemanager.visible = true
	tetris_spawner.visible = true
	objects_list.visible = true
	button.visible = true
