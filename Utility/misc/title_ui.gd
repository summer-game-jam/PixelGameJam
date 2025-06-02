extends Control

# Where title screen functions go
# Remeber, the title screen shouldn't do any work
# The title screen will emit signals/call functions to other nodes/scenes that are specialized for that job

# timer container
var timer: Timer

# emitted when quit button is pressed. this node doesn't handle quiting!
signal quit_request

# creates a timer that will play the starting animation after a period of time
func _ready() -> void:
	timer = Timer.new()
	timer.wait_time = 0.5
	timer.connect("timeout", fade_out)
	add_child(timer)
	timer.one_shot = true
	timer.start()

# play the starting animaiton
func fade_out() -> void:
	if timer:
		timer.queue_free()
	$AnimationPlayer.play("fade_out")

# Tell parent that user wishes to exit
func quit() -> void:
	emit_signal("quit_request")

# Joke, Should be changed with a signal to tell parent to start game. Title doesn't start game
func _on_button_pressed() -> void:
	$AudioStreamPlayer2D.play()
