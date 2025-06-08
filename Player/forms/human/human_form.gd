extends Player_Base
class_name Human

var attacking: bool = false
var in_light: bool = false
var is_dead: bool = false

func _ready() -> void:
	$Attack/AnimationPlayer.play("RESET")

func _physics_process(delta: float) -> void:
	if is_dead:
		velocity.x = 0
		if is_on_floor():
			velocity.y = 0
		move_and_slide()
		return
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
		$Direction.determind_direction(velocity)
	move_and_slide()

func _on_attack_attack_done() -> void:
	attacking = false

func on_hit():
	print("ow")
	is_dead = true
	$AnimatedSprite2D.visible = false
	$Poof.emitting = true
