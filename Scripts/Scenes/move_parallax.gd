@tool
extends ParallaxLayer
class_name Moving_Parallax

# moves parallax background to right. good for static screens that want a animate background

## False for background to move right
## True for background to move left
@export var direction:bool = false

## how fast the background moves (px/sec)
@export var speed:float = 100

func _process(delta: float) -> void:
	if direction:
		motion_offset.x -= speed * delta
	else:
		motion_offset.x += speed * delta
