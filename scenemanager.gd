extends Node

var scene : Dictionary = {"Level1":"res://scenes/level_building.tscn",
							"Level2":"res://scenes/level_2.tscn"}

func transition_to_scene(level: String):
	var scene_path : String = scene.get(level)
	
	if scene_path != null:
		await get_tree().create_timer(1.0).timeout
		get_tree().change_scene_to_file(scene_path)
	
