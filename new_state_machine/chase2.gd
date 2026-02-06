extends Node


func enter():
	if owner.is_dead:
		return
	owner.play_anim("walk")
	
	
func update(_delta):
	if owner.is_dead:
		return
	if owner.player:
		var diff = owner.player.global_position.x - owner.global_position.x
		var dir = sign(diff) # calculate the difference of the distance
		owner.set_direction(dir)
		owner.velocity.x = dir * owner.chase_speed
		
	else:
		owner.state_machine.change_state("Patrol")
		
func exit(): 
	pass
