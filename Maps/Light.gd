@tool
extends Node2D
class_name Light

@export var sprite: AnimatedSprite2D

func _process(delta: float) -> void:
	if Engine.is_editor_hint(): # This runs in editor
		# Align pointlight and area
		$PointLight2D.set_global_position($Area2D.get_global_position())
		
		# Scale texture to fit its Area2D
		$PointLight2D.texture_scale = ($Area2D/CollisionShape2D.shape.get_radius()) / 31.5

func disable_light():
	if sprite:
		sprite.play("dead")
	$PointLight2D.visible = false
	$Area2D.monitoring = false
