extends Node

var is_attacking : bool = false

func enter():
	is_attacking = false
	perform_attack()
	
	


	
func perform_attack():
	if owner.state_machine.current_state != self: return
	
	
	owner.play_anim("hit")
	is_attacking = true
	owner.velocity.x = 0  
	owner.play_anim("attack")
	
	# Damage delay
	await get_tree().create_timer(0.4).timeout
	
	# Actual Damage Logic
	if owner.state_machine.current_state == self:
		print("Player hit for: ", owner.damage_amount)
		# Agar player ki health script hai: owner.player.take_damage(owner.damage_amount)

	# Animation finish delay
	await get_tree().create_timer(0.4).timeout
	is_attacking = false
	
	# Attack khatam hone ke baad check karo ki kya player abhi bhi range mein hai
	# (Note: Agar signal ne state change nahi kiya, to hum loop karenge)
	if owner.state_machine.current_state == self:
		perform_attack()

func update(_delta):
	owner.velocity.x = 0 # Attack ke waqt move nahi karega

func exit():
	is_attacking = false
