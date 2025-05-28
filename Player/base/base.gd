extends CharacterBody2D
class_name Player_Base

func get_direction() -> Direction.directions:
	var direction_node = find_direction_node()
	if direction_node:
		return direction_node.direction
	print("couldn't find direction node in get_direction. likey occured during swapping")
	return Direction.directions.left

func set_direction(new_direction: Direction.directions) -> void:
	var direction_node = find_direction_node()
	if direction_node:
		direction_node.direction = new_direction
	else:
		print("couldn't find direction node in get_direction. likey occured during swapping")

func find_direction_node() -> Direction:
	for child in get_children():
		if child is Direction:
			return child
	return null
