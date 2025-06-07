extends Node
class_name Fill_Gauge

signal gauge_emptied

@export var gauge_max: float = 100

var current_gauge: float = gauge_max

func reset():
	current_gauge = gauge_max

func empty_gauge(amount: float):
	current_gauge = clamp(current_gauge - amount, 0, gauge_max)
	if is_gauge_empty():
		emit_signal("gauge_emptied")

func fill_gauge(amount: float):
	current_gauge = clamp(current_gauge + amount, 0, gauge_max)

func is_gauge_empty() -> bool:
	return abs(current_gauge) < 0.00000001

func is_gauge_full() -> bool:
	return abs(current_gauge - 100) < 0.00000001

func gauge_precent() -> float:
	return current_gauge / gauge_max
	
