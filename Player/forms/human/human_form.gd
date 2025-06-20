extends Player_Base
class_name Human

var attacking: bool = false
var in_light: bool = false


func _ready() -> void:
	$Attack/AnimationPlayer.play("RESET")

func _physics_process(delta: float) -> void:
	in_light = $LightDetector.in_light
	if Input.is_action_just_pressed("left_click") and !attacking and is_on_floor():
		attacking = true
		velocity = Vector2(0, 0)
		$Attack.attack()
	elif !attacking:
		$Humaniod_Player_Movement.movement_action(delta)
		if velocity == Vector2.ZERO or !is_on_floor():
			$AnimatedSprite2D.play("idle")
		else:
			$AnimatedSprite2D.play("move")
		print($Direction.direction)
		$Direction.determind_direction(velocity)
	move_and_slide()

func _on_attack_attack_done() -> void:
	attacking = false
