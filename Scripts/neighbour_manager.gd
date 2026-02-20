extends Node

@onready var updated_objects: Array = []

func update_integrity(body) -> void:
	#print("i am " + body.name)
	updated_objects.append(body)
	#print("my neighbours are:")
	body.max_neighbour_integrity = 0
	await get_tree().process_frame
	var neighbours = body.neighbour_area2d.get_overlapping_areas()
	#print("NEIGHNEIGH: " + str(neighbours))
	for i in neighbours.size():
		#print(neighbours[i].get_parent().name)
		body.max_neighbour_integrity = max(body.max_neighbour_integrity, neighbours[i].get_parent().integrity)
	#print("max neighbour integrity is " + str(body.max_neighbour_integrity))
	body.integrity = body.max_neighbour_integrity - 1
	
	body.integrity_text.text = str(body.integrity)
	#print("my integrity is " + str(body.integrity))
	#print("starting propagation. already updated objects are: " + str(updated_objects))
	for i in neighbours.size():
		if neighbours[i].get_parent() not in updated_objects and neighbours[i].get_parent() is CharacterBody2D:
			update_integrity(neighbours[i].get_parent())

func check_integrity(body) -> bool:
	body.max_neighbour_integrity = 0
	await get_tree().process_frame
	var neighbours = body.neighbour_area2d.get_overlapping_areas()
	for i in neighbours.size():
		body.max_neighbour_integrity = max(body.max_neighbour_integrity, neighbours[i].get_parent().integrity)
	var temp_integrity = body.max_neighbour_integrity - 1
	body.integrity_text.text = str(temp_integrity)
	return temp_integrity > 0
	
func new_neighbour(body) -> void:
	#print("new neighbour!")
	updated_objects = []
	update_integrity(body)
