extends Node
class_name Humanoid_Movement

@export var speed_limit: float = 500
@export var horizontal_move_speed = 20000
@export var jump_power = 400
@export var gravity = 1000
@export var air_control_factor: float = 0.5 
@export var air_drag: float = 0.1           

@onready var parent_body: CharacterBody2D = get_parent()

func movement_action(delta: float) -> void:
	var movement_vector = Vector2.ZERO
	
	if Input.is_action_pressed("left"):
		movement_vector.x = -1
	elif Input.is_action_pressed("right"):
		movement_vector.x = 1

	if parent_body.is_on_floor():
		if Input.is_action_just_pressed("space"):
			parent_body.velocity.y = -jump_power
		else:
			parent_body.velocity.y = 0
		parent_body.velocity.x = horizontal_move_speed * movement_vector.x * delta
	else:
		parent_body.velocity.y += gravity * delta
		if abs(parent_body.velocity.x) < speed_limit / 2:
			parent_body.velocity.x += horizontal_move_speed * movement_vector.x * delta * air_control_factor
		parent_body.velocity.x = lerp(parent_body.velocity.x, 0.0, air_drag)
		parent_body.velocity.x = clamp(parent_body.velocity.x, -speed_limit, speed_limit)
