extends CharacterBody2D
class_name Entity

@export var max_health: int = 1
var current_health: int = max_health

func on_hit():
	pass

func die():
	pass
	#modulate = Color("black")
