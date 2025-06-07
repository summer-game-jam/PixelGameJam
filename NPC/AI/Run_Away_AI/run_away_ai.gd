extends AI_Base
class_name Run_Away_AI

func perform_best_action(npc: NPC, delta: float):
	var players: Array[Node] = get_tree().get_nodes_in_group("player")
	if players.size() > 0:
		var player = players[0]
		var movement_vector
		if npc.global_position.x > player.global_position.x:
			movement_vector = 1
		else:
			movement_vector = -1
		npc.velocity.x = movement_vector * npc.move_speed * delta * 3
