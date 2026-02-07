extends Node

var current_state : Node = null

func _ready():
	await owner.ready
	change_state("Patrol")
	
func _physics_process(delta):
	if not owner or owner.is_dead:
		set_physics_process(false)
		return
	if current_state:
		current_state.update(delta)  # update the state
		
func change_state(state_name : String):
	if owner.is_dead:
		return
	var new_state = get_node_or_null(state_name)
	if new_state == null or new_state == current_state:
		return
	
	if current_state:
		current_state.exit()
	current_state = new_state
	current_state.enter() 
	
		
		
