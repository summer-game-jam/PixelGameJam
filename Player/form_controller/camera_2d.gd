extends Camera2D

var thing_to_follow: Node2D = null
@export var base_speed: float = 200.0
@export var speed_multiplier: float = 2.0

func _process(delta: float) -> void:
	if thing_to_follow == null:
		return

	var target_position = thing_to_follow.global_position
	var current_position = global_position
	var direction = target_position - current_position
	var distance = direction.length()

	if distance < 1.0:
		return  # Close enough

	# Speed increases with distance
	var speed = base_speed + distance * speed_multiplier
	var movement = direction.normalized() * speed * delta

	# Prevent overshooting
	if movement.length() > distance:
		global_position = target_position
	else:
		global_position += movement

func set_follow_target(target: Node2D) -> void:
	thing_to_follow = target
