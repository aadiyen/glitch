extends CharacterBody2D

const GRAVITY : int = 1000


func _physics_process(delta):
	if !is_on_floor():
		velocity.y += GRAVITY
	move_and_slide()
