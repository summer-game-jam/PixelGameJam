extends CharacterBody2D
class_name NPC

@export var normalAI: AI_Base
@export var combatAI: AI_Base
@export var alertAI: AI_Base


# normal, no vampire threat go on about day
# alert, VAMPIRE!!! AHHH kill it or run away
# scared, detects faster but don't know where vampire is, can make other npc scared
enum status {
	normal = 1,
	combat = 2,
	alert = 3
}
