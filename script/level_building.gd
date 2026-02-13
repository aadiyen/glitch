extends Node2D
var game_end_scene = preload("res://scenes/level_2.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AudioStreamPlayer.play()



func _on_gameendarea_body_entered(body: Node2D) -> void:
	var game_end_scene_instance = game_end_scene.instantiate()
	get_tree().get_root().add_child(game_end_scene_instance)
	$AudioStreamPlayer.stop()
