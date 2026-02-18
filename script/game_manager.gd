extends Node
var main_menu_screen = preload("res://scenes/main_menu.tscn")
var pause_menu_screen = preload("res://assets/ui/pause_menu_screen.tscn") # pause menu path
#var level_1 = preload("res://scenes/level_building.tscn") # scene path 

func start_game():
	if get_tree().paused:
		continue_game()
		return
	Scenemanager.transition_to_scene("Level1")
	#transition_to(level_1.resource_path)
	
func exit_game():
	get_tree().quit()
	
func pause_game():
	get_tree().paused = true
	var pause_menu_screen_instance = pause_menu_screen.instantiate()
	get_tree().get_root().add_child(pause_menu_screen_instance)
	
func continue_game():
	get_tree().paused = false

func main_menu():
	var main_menu_screen_instance = main_menu_screen.instantiate()
	get_tree().get_root().add_child(main_menu_screen_instance)


#func transition_to(scene_path):  # transition to scene path
	#await get_tree().create_timer(0.1).timeout # time will take to open the scene
	#get_tree().change_scene_to_file(scene_path)
	
