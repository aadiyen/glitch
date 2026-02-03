extends Node

var current_state : Node = null


func _ready():
	await owner.ready
	change_state("Patrol")


func _physics_process(delta):
	if current_state:
		current_state.update(delta)

func change_state(state_name: String):
	var new_state = get_node_or_null(state_name)
	if new_state == null or new_state == current_state:
		return
		
	if current_state:
		current_state.exit()
	current_state = new_state
	current_state.enter()
			
			
	
	
