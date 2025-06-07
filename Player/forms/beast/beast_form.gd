extends Player_Base
class_name Beast

var attacking = false

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("left_click") and !attacking and is_on_floor():
		attacking = true
		velocity = Vector2(0, 0)
		$Attack.attack()
	$Humaniod_Player_Movement.movement_action(delta)
	if !attacking:
		if velocity == Vector2.ZERO:
			$AnimatedSprite2D.play("idle")
		else:
			$AnimatedSprite2D.play("move")
		$Direction.determind_direction(velocity)
	move_and_slide()


func _on_attack_attack_done() -> void:
	attacking = false
