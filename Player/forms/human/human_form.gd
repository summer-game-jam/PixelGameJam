extends Player_Base
class_name Human

func _physics_process(delta: float) -> void:
	$Humaniod_Player_Movement.movement_action(delta)
	if velocity == Vector2.ZERO:
		$AnimatedSprite2D.play("idle")
	else:
		$AnimatedSprite2D.play("move")
	$Direction.determind_direction(velocity)
	move_and_slide()
