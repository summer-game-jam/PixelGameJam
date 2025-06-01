extends Node2D
class_name raycast_handler

var ray_casts: Array[RayCast2D] = []

func _ready() -> void:
	for child in get_children():
		if child is RayCast2D:
			ray_casts.append(child)

func ray_cast_check(min_count:int = 0) -> bool:
	var ray_count:int = 0
	for child: RayCast2D in ray_casts:
		if child.is_colliding():
			ray_count += 1
	return ray_count > min_count

# TODO finish
func find_first(min_count: int = 0) -> Node:
	var nodes_found = []
	for child: RayCast2D in ray_casts:
		if child.is_colliding() and child.get_collider() is Player_Base:
			return child.get_collider()
	return null

func force_raycast_update():
	for cast in ray_casts:
		cast.force_raycast_update()
