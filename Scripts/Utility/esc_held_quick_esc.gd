extends Node

# Debug escape tool. Hold ESC to make the game exit. Set automatic_exit to false if
# your game needs to exit in a different manner.

## Flag true if you want the game to close when esc held.
## Flag false if you want the game to instead only emit a signal to user created exit function
@export var automatic_exit:bool = true

# seconds
# max time till exit action is called
const MAX_HOLD_TIME: float = 3
# time user held  button for
var time_esc_held: float = 0

# signal emit
signal esc_held

func _process(delta: float) -> void:
	if Input.is_action_pressed("esc"):
		time_esc_held += delta
		if time_esc_held >= MAX_HOLD_TIME:
			emit_signal("esc_held")
			if automatic_exit:
				get_tree().quit()
	else:
		time_esc_held = 0
