extends AI_Base
class_name Wonder_AI

enum states {
	idle = 1,
	walk = 2,
	turn_around = 3,
}

var current_state: states = states.idle

var min_random_range_timer: float = 1
var max_random_range_timer: float = 5

func perform_best_action(npc: NPC, delta: float):
	var direction: int = 1
	if npc.direction.direction == Direction.directions.left:
		direction = -1
	
	if current_state == states.walk:
		npc.velocity.x = npc.move_speed * delta * direction
		npc.sprite.play("moving")
	else:
		npc.velocity.x = 0

func _on_wait_timer_timeout() -> void:
	match current_state:
		states.idle:
			current_state = states.walk
		states.walk:
			current_state = states.idle
	restart_timer()

func reached_wall(npc: NPC):
	npc.velocity.x = 0
	npc.direction.reverse_direction()
	restart_timer()

func restart_timer():
	$wait_timer.wait_time = randf_range(min_random_range_timer, max_random_range_timer)
	$wait_timer.start()
