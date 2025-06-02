extends Node
class_name Direction

enum directions {
	left = 1,
	right = 2
}

@export var direction: directions = directions.left

@onready var parent_body: CharacterBody2D = get_parent()

func _ready() -> void:
	swap_direction(direction)

func swap_direction(new_direction: directions):
	match new_direction:
		directions.left:
			if (parent_body.scale.y != 1):
				return
		directions.right:
			if (parent_body.scale.y != -1):
				return
	direction = new_direction
	parent_body.scale.x = -parent_body.scale.x

func determind_direction(velocity: Vector2):
	if velocity.x < -10:
		swap_direction(directions.left)
	elif velocity.x > 10:
		swap_direction(directions.right)

func _on_property_list_changed() -> void:
	swap_direction(direction)

func reverse_direction():
	if direction == directions.left:
		swap_direction(directions.right)
	else:
		swap_direction(directions.left)
