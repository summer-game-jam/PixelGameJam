extends Entity
class_name NPC

@export var normal_AI: AI_Base
@export var combat_AI: AI_Base
@export var alert_AI: AI_Base

var current_ai: AI_Base = null

@onready var detection = $NpcFov
@onready var direction = $Direction
@onready var wall := $wall
@onready var ground := $ground

var move_speed = 5000
var gravity = 1000

# normal, no vampire threat go on about day
# alert, VAMPIRE!!! AHHH kill it or run away
# scared, detects faster but don't know where vampire is, can make other npc scared
enum states {
	normal = 1,
	combat = 2,
	alert = 3,
	dead = 4
}

var status:states = states.normal

func _physics_process(delta: float) -> void:
	velocity.x = 0
	# determind y (always the same for all, can be overwritten by ai)
	if is_on_floor():
		velocity.y = 0
		var determined_ai: AI_Base = determind_state(delta)
		if determined_ai != current_ai:
			determined_ai.swap_to_ai()
			current_ai = determined_ai
		if determined_ai:
			determined_ai.perform_best_action(self, delta)
			# true means can't progress any further
			if wall.ray_cast_check() or !ground.ray_cast_check():
				determined_ai.reached_wall(self)
				force_update_transform()
				wall.force_raycast_update()
	else:
		velocity.y += gravity * delta
	
	#apply determind movement
	move_and_slide()

func determind_state(delta: float) -> AI_Base:
	var detection_precent: float = detection.scan_enviroment(delta)
	if detection_precent >= 1:
		status = states.combat
	
	if status == states.combat and abs(detection_precent) < 0.000001:
		status = states.alert
	
	match status:
		states.normal:
			return normal_AI
		states.combat:
			return combat_AI
		states.alert:
			return alert_AI
	return null

func on_hit():
	current_health -= 1
	if current_health <= 0:
		status = states.dead
