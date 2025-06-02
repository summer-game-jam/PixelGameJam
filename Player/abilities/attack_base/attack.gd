extends Area2D
class_name Attack

# faster to track hit box rather than entity
var entities_hit: Array[Hit_Box] = []

@export var animation: String = "attack"

var anim_player: AnimationPlayer

signal attack_done

func _ready() -> void:
	monitoring = false
	for child in get_children():
		if child is AnimationPlayer:
			anim_player = child
			anim_player.connect("animation_finished", attack_finished)
			break

func attack():
	if !anim_player.is_playing():
		entities_hit = []
		anim_player.play(animation)

func attack_finished(name: StringName):
	monitoring = false
	emit_signal("attack_done")

# must not be self
# must be a hit box of a entity
# must have not been hit by same attack
func _on_area_entered(area: Area2D) -> void:
	if area is Hit_Box:
		var hit_box: Hit_Box = area
		if !hit_box.parent == get_parent():
			if !(hit_box in entities_hit):
				hit_box.parent.on_hit()
				entities_hit.append(hit_box)
