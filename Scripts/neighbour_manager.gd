extends Node

@onready var updated_objects: Array = []

func update_integrity(body) -> void:
	updated_objects.append(body)
	body.max_neighbour_integrity = 0
	await get_tree().process_frame
	var neighbours = body.neighbour_area2d.get_overlapping_areas()
	for i in neighbours.size():
		body.max_neighbour_integrity = max(body.max_neighbour_integrity, neighbours[i].get_parent().integrity)
	body.integrity = body.max_neighbour_integrity - 1

	for i in neighbours.size():
		if neighbours[i].get_parent() not in updated_objects and neighbours[i].get_parent() is CharacterBody2D:
			update_integrity(neighbours[i].get_parent())

func check_integrity(body) -> bool:
	body.max_neighbour_integrity = 0
	await get_tree().process_frame
	var neighbours = body.neighbour_area2d.get_overlapping_areas()
	for i in neighbours.size():
		body.max_neighbour_integrity = max(body.max_neighbour_integrity, neighbours[i].get_parent().integrity)
	body.integrity = body.max_neighbour_integrity - 1
	return body.integrity > 0
	
func new_neighbour(body) -> void:
	updated_objects = []
	update_integrity(body)
