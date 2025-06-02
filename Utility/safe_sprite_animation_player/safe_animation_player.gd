extends AnimatedSprite2D
class_name Safe_Animation_Player

func play_animation(animation_name: String):
	if animation != animation_name:
		animation = animation_name

func force_animation(animation_name: String):
	animation = animation_name
