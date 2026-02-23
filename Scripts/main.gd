extends Node

@export var title_screen: Control
@export var floor: StaticBody2D
@export var background: Node2D
@export var music_player: AudioStreamPlayer
@export var ui2: Control
@export var silhouettemanager: Control
@export var tetris_spawner: Node2D
@export var objects_list: Node2D
@export var button: TextureButton
@export var sfx: Node
@export var tutorial_ui: Control
@export var credits_ui: Control

func _on_start_button_button_up() -> void:
	title_screen.visible = false
	title_screen.process_mode = Node.PROCESS_MODE_DISABLED
	tutorial_ui.visible = true
	floor.visible = true
	background.visible = true
	ui2.visible = true
	silhouettemanager.visible = true
	tetris_spawner.visible = true
	objects_list.visible = true
	button.visible = true


func _on_silhouette_manager_all_levels_beat() -> void:
	tutorial_ui.visible = false
	floor.visible = false
	ui2.visible = false
	silhouettemanager.visible = false
	tetris_spawner.visible = false
	objects_list.visible = false
	button.visible = false
	credits_ui.visible = true
