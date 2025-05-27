extends CharacterBody2D
class_name Villager

enum directions {
	left = 1,
	right = 2
}

var move_speed = 10000
var alive = true

@onready var left_cast: raycast_handler = $left
@onready var right_cast: raycast_handler = $right

@onready var sprite: Sprite2D = $Sprite2D

var direction = directions.left

func _ready() -> void:
	swap_direction()

func _physics_process(delta: float) -> void:
	if is_on_floor():
		if direction == directions.left:
			if left_cast.ray_cast_check():
				velocity.x = -move_speed * delta
			else:
				swap_direction()
		else:
			if right_cast.ray_cast_check():
				velocity.x = move_speed * delta
			else:
				swap_direction()
	
	if is_on_floor():
		velocity.y = 0
	else:
		velocity.y += 100 * delta
	move_and_slide()

func swap_direction():
	if direction == directions.left:
		direction = directions.right
		sprite.flip_h = false
	else:
		direction = directions.left
		sprite.flip_h = true
