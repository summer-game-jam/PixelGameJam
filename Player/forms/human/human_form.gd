extends Player_Base
class_name Human

var attacking: bool = false
var touched_ground: bool = true

func _ready() -> void:
	$Attack/AnimationPlayer.play("RESET")

func _physics_process(delta: float) -> void:
	if is_on_floor():
		touched_ground = true
	if Input.is_action_just_pressed("left_click") and !attacking and touched_ground:
		attacking = true
		touched_ground = false
		velocity = Vector2(0, 0)
		$Attack.attack()
	elif !attacking:
		$Humaniod_Player_Movement.movement_action(delta)
		if velocity == Vector2.ZERO:
			$AnimatedSprite2D.play("idle")
		else:
			$AnimatedSprite2D.play("move")
		$Direction.determind_direction(velocity)
	move_and_slide()

func _on_attack_attack_done() -> void:
	attacking = false
