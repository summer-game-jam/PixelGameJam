extends CharacterBody2D
class_name Bat

var move_speed: float = 100000

func _physics_process(delta: float) -> void:
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
	velocity = movement_vector * move_speed * delta
	move_and_slide()
