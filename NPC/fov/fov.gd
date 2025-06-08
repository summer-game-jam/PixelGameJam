extends Node
class_name FOV

@onready var detection_meter = $FillGauge
## per sec
@export var detection_rate: float = 70
## per sec
@export var forget_rate: float = 30
@export var time_to_start_forgeting = 2

@onready var raycasts = $Raycast_Handler
@export var min_number_raycast: int = 3

@onready var label = $Label

@onready var timer_since_saw_last_form: Timer = $last_form_detected
var last_form_detected: String = ""
var vampire_compramised: bool = false
var vampire_location_spotted: Vector2

signal form_swap_witnessed

func _ready() -> void:
	detection_meter.empty_gauge(1000)

# should be called every frame by npc first
# 1. check the raycast for player
# 2. check what form player is
# 3. check if we saw transformation
# 4. apply update to gauge based on what was detected
func scan_enviroment(delta: float) -> float:
	# 1
	var detected_node: Node = raycasts.find_first(min_number_raycast)

	# 2
	if detected_node is Player_Base:
		# 3
		if timer_since_saw_last_form.wait_time > 0:
			# saw transformation
			if last_form_detected != "" and detected_node.name != last_form_detected and !vampire_compramised:
				vampire_compramised = true
				detection_meter.fill_gauge(100)
			# otherwise its the same form from last frame
		last_form_detected = detected_node.name
		timer_since_saw_last_form.start()
		# 4
		if detected_node is Human:
			if vampire_compramised:
				detection_meter.fill_gauge(detection_rate * delta * 0.7)
				vampire_location_spotted = detected_node.global_position
			elif detected_node.attacking:
				vampire_compramised = true
				detection_meter.fill_gauge(10000)
			else:
				detection_meter.empty_gauge(delta * forget_rate)
		elif detected_node is Beast:
			detection_meter.fill_gauge(delta * detection_rate)
			vampire_location_spotted = detected_node.global_position
		elif detected_node is Bat:
				detection_meter.empty_gauge(delta * forget_rate)
	else:
		detection_meter.empty_gauge(delta * forget_rate)
	$Label.text = str(detection_meter.gauge_precent())
	return detection_meter.gauge_precent()

func _on_last_form_detected_timeout() -> void:
	last_form_detected = ""
