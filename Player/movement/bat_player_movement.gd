extends Node
class_name Bat_Player_Movement

@export var move_speed: Vector2 = Vector2(30000, 40000)

@onready var parent_body: CharacterBody2D = get_parent()

func movement_action(delta: float) -> void:
	var movement_vector = Vector2.ZERO
	if Input.is_action_pressed("up"):
		movement_vector.y = -1
	elif Input.is_action_pressed("down"):
		movement_vector.y = 1
	if Input.is_action_pressed("right"):
		movement_vector.x = 1
	elif Input.is_action_pressed("left"):
		movement_vector.x = -1
	
	movement_vector = movement_vector.normalized()
	parent_body.velocity = movement_vector * move_speed * delta
