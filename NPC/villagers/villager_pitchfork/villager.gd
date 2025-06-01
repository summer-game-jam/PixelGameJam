extends CharacterBody2D
class_name NPC

@export var normalAI: AI_Base
@export var combat_AI: AI_Base
@export var alert_AI: AI_Base


# normal, no vampire threat go on about day
# alert, VAMPIRE!!! AHHH kill it or run away
# scared, detects faster but don't know where vampire is, can make other npc scared
enum states {
	normal = 1,
	combat = 2,
	alert = 3
}

var status:states = states.normal

func _process(delta: float) -> void:
	match status:
		states.normal:
			normal_AI.perform_best_action(self)
