extends CharacterBody2D
class_name Villager



var move_speed = 10000
var alive = true

@onready var left_cast: raycast_handler = $left
@onready var right_cast: raycast_handler = $right

@onready var sprite: Sprite2D = $Sprite2D
