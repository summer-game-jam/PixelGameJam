extends CharacterBody2D
class_name Human

func _physics_process(delta: float) -> void:
	$Humaniod_Player_Movement.movement_action(delta)
	move_and_slide()
