extends Player_Base
class_name Bat

enum modes {
	flight = 1,
	grounded = 2
}

var flight_meter: Fill_Gauge

var current_state: modes = modes.flight

func _ready() -> void:
	flight_meter.connect("gauge_emptied", gauge_empty)
	$AnimatedSprite2D.play("fly")

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("space"):
		if current_state == modes.grounded and !flight_meter.is_gauge_empty():
			current_state = modes.flight
		elif current_state == modes.flight:
			velocity.y = 0
			current_state = modes.grounded
	
	match current_state:
		modes.flight:
			$Bat_Player_Movement.movement_action(delta)
			flight_meter.empty_gauge(delta)
		modes.grounded:
			$Humaniod_Player_Movement.movement_action(delta)
	
	$Direction.determind_direction(velocity)
	move_and_slide()
	
	$ProgressBar.value = flight_meter.current_gauge / flight_meter.gauge_max * 100

func gauge_empty():
	velocity.y = 0
	current_state = modes.grounded
