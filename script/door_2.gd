extends Node2D

var game_end_scene = preload("res://scenes/game_end_scene.tscn")




func _on_exit_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		var player = body as CharacterBody2D
		player.queue_free()
		
		await get_tree().create_timer(2).timeout
		
		var game_end_scene_instance = game_end_scene.instantiate()
		get_tree().get_root().add_child(game_end_scene_instance)
		
	
		
		
		
		
