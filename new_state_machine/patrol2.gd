extends Node
var moving_right = true

func enter():
	owner.play_anim("walk")
	
func update(_delta):
	if owner.wall_ray.is_colliding() or \
	   (moving_right and owner.global_position.x >= owner.patrol_right_x) or \
	   (not moving_right and owner.global_position.x <= owner.patrol_left_x):
		moving_right = !moving_right
		
	var dir = 1 if moving_right else -1
	owner.set_direction(dir)
	owner.velocity.x = dir * owner.speed 

func exit():
	pass
