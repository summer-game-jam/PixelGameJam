extends CharacterBody2D
class_name Human

var speed_limit: float = 500

var horizontal_move_speed = 20000
var jumpPower = 400
var gravity = 1000

func _physics_process(delta: float) -> void:
	var movement_vector: Vector2 = Vector2.ZERO
	
	if Input.is_action_pressed("left"):
		movement_vector.x = -1
	elif Input.is_action_pressed("right"):
		movement_vector.x = 1
	
	if is_on_floor():
		if Input.is_action_just_pressed("space"):
			velocity.y = -jumpPower
		else:
			velocity.y = 0
		velocity.x = horizontal_move_speed * movement_vector.x * delta
	else:
		velocity.y += gravity * delta
		velocity.x += horizontal_move_speed * movement_vector.x * delta * 0.1
		velocity.x = clamp(velocity.x, -speed_limit, speed_limit)
	
	move_and_slide()
