extends Sprite2D
class_name Moving_Sprite

func _process(delta: float) -> void:
	position.x += 100 * delta
