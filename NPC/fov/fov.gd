extends Node
class_name FOV

@onready var detection_meter = $FillGauge
## per sec
@export var detection_rate: float = 20
## per sec
@export var forget_rate: float = 30
@export var time_to_start_forgeting = 2

@onready var raycasts = $Raycast_Handler
@export var min_number_raycast: int = 3

var last_form_detected: Player_Base
var vampire_compramised: bool = false

signal form_swap_witnessed

# should be called every frame by npc first
func scan_enviroment(delta: float) -> void:
	var detected_node: Node = raycasts.find_first(min_number_raycast)
	if detected_node is Player_Base:
		if last_form_detected and last_form_detected != detected_node:
			emit_signal("form_swap_witnessed")
			vampire_compramised = true
		last_form_detected = detected_node
		match detected_node.get_class():
			Human:
					if vampire_compramised:
						detection_meter.fill_gauge(delta)
					else:
						detection_meter.empty_gauge(delta)
			Beast:
				detection_meter.fill_gauge(delta)
			Bat:
				detection_meter.empty_gauge(delta)
	else:
		detected_node = null
		detection_meter.empty_gauge(delta)
