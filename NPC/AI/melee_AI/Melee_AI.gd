extends AI_Base
class_name Melee_AI

enum states {
	surprised = 1,
	combat = 2,
	attacking = 3
}

@export var attempt_attack_range: float = 220

signal attack

var current_state = states.surprised

func perform_best_action(npc: NPC, delta: float):
	print(current_state)
	if current_state == states.combat:
		var players: Array[Node] = get_tree().get_nodes_in_group("player")
		if players.size() > 0:
			var player = players[0]
			# face them
			if npc.global_position.x < player.global_position.x:
				npc.direction.swap_direction(Direction.directions.right)
			else:
				npc.direction.swap_direction(Direction.directions.left)
			# attack
			if abs(npc.global_position.distance_to(player.global_position)) <= attempt_attack_range:
				current_state = states.attacking
				emit_signal("attack")
			# move closer
			else:
				var movement_vector: float = 1
				if npc.global_position.x > player.global_position.x:
					movement_vector = -1
				npc.velocity.x = movement_vector * npc.move_speed * delta * 2.5

func reached_wall(npc: NPC):
	npc.velocity.x = 0

func swap_to_ai():
	print("swap")
	if current_state != states.attacking:
		current_state = states.surprised
		$surprise_timer.start()

func attack_finished(_temp: StringName):
	current_state = states.combat

func surpise_over():
	print("over")
	if current_state == states.surprised:
		current_state = states.combat
