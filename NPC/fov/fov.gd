extends Node
class_name FOV

@onready var detection_meter = $FillGauge
## per sec
@export var detection_rate: float = 40
## per sec
@export var forget_rate: float = 30
@export var time_to_start_forgeting = 2

@onready var raycasts = $Raycast_Handler
@export var min_number_raycast: int = 3

@onready var label = $label

var last_form_detected: Player_Base
var vampire_compramised: bool = false

signal form_swap_witnessed

func _ready() -> void:
	detection_meter.empty_gauge(1000)

# should be called every frame by npc first
func scan_enviroment(delta: float) -> void:
	var detected_node: Node = raycasts.find_first(min_number_raycast)
	if detected_node is Player_Base:
		#print(detected_node, last_form_detected)
		if last_form_detected and last_form_detected != detected_node:
			if vampire_compramised:
				print("oh no")
			vampire_compramised = true
		last_form_detected = detected_node
		if detected_node is Human:
			if vampire_compramised:
				print("oh no")
				detection_meter.fill_gauge(detection_rate * delta)
			else:
				detection_meter.empty_gauge(delta * forget_rate)
		elif detected_node is Beast:
			detection_meter.fill_gauge(delta * detection_rate)
		elif detected_node is Bat:
				detection_meter.empty_gauge(delta * forget_rate)
	else:
		last_form_detected = null
		detection_meter.empty_gauge(delta * forget_rate)
	$Label.text = str(detection_meter.gauge_precent())
	return detection_meter.gauge_precent()
