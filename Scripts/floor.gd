extends StaticBody2D

@onready var integrity: int = 6
@onready var max_neighbour_integrity: int = 0

@onready var parent_body2d = $".."
@onready var neighbour_area2d: Area2D = $"Neighbour"
