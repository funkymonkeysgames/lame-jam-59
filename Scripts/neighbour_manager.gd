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

func check_integrity(body: Block) -> bool:
	body.max_neighbour_integrity = 0
	await get_tree().process_frame
	var neighbours = body.neighbour_area2d.get_overlapping_areas()
	var found_good_neighbour: bool = false
	# sorry for my retardation here
	for n in neighbours:
		if n != body.neighbour_area2d and n != body.noclipzone:
			found_good_neighbour = true
			break
	if not found_good_neighbour:
		body.integrity = 0
		return false
		
	for i in neighbours.size():
		body.max_neighbour_integrity = max(body.max_neighbour_integrity, neighbours[i].get_parent().integrity)
	body.integrity = body.max_neighbour_integrity - 1
	return body.integrity > 0
	
func new_neighbour(body) -> void:
	updated_objects = []
	update_integrity(body)
