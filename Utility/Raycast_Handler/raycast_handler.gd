extends Node2D
class_name raycast_handler

var ray_casts: Array[RayCast2D] = []

func _ready() -> void:
	for child in get_children():
		if child is RayCast2D:
			ray_casts.append(child)

func update_targets() -> void:
	for child: RayCast2D in ray_casts:
		if child.has_meta("target_global"):
			child.set_target_position(child.to_local(child.get_meta("target_global")))

func ray_cast_check(min_count:int = 0) -> bool:
	var ray_count:int = 0
	for child: RayCast2D in ray_casts:
		if child.is_colliding():
			ray_count += 1
	return ray_count > min_count

func check_all_colliding() -> int:
	for child: RayCast2D in ray_casts:
		if !child.is_colliding():
			return false
	return true

func cast_new_ray(target: Vector2, layer: int) -> void:
	# Add child ray
	var ray = RayCast2D.new()
	add_child(ray)
	ray_casts.append(ray)
	
	# Point to target
	ray.set_target_position(ray.to_local(target))
	
	# Set collision mask
	if layer > 0 and layer < 33:
		ray.set_collision_mask(1 << (layer - 1))
		print("ray cast")
	
	# Add metadata to store global target
		ray.set_meta("target_global", target)

func delete_ray(target: Vector2) -> void:
	for child: RayCast2D in ray_casts:
		if child.has_meta("target_global") and child.get_meta("target_global").is_equal_approx(target):
			ray_casts.erase(child)
			child.queue_free()
			print("ray freed")

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
