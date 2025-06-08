extends Control

func update(value:int, value2:int):
	$MarginContainer/ProgressBar/HBoxContainer/left.text = str(value)
	$MarginContainer/ProgressBar/HBoxContainer/right.text = str(value2)
	
	$MarginContainer/ProgressBar.value = value
	$MarginContainer/ProgressBar.max_value = value2
