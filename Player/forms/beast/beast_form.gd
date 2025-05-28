extends Player_Base
class_name Beast

func _physics_process(delta: float) -> void:
	$Humaniod_Player_Movement.movement_action(delta)
	$Direction.determind_direction(velocity)
	move_and_slide()
