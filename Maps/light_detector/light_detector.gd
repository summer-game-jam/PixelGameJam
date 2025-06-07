extends Node2D
class_name LightDetector

# @onready var colliding_lights = []
@onready var rays: raycast_handler = $raycast_handler
@onready var label = $Label

## true = light; flase = dark
var in_light: bool = false

func _physics_process(delta: float) -> void:
	rays.update_targets()
	in_light = !rays.check_all_colliding()
	if !rays.check_all_colliding():
		label.set_text("Light")
	else:
		label.set_text("Dark")

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent() is Light:
		# colliding_lights.append(area)
		rays.cast_new_ray(area.get_global_position(), 8)

func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.get_parent() is Light:
		rays.delete_ray(area.get_global_position())
		# colliding_lights.erase(area)
