extends CanvasLayer
@export var current_scene = preload("res://scenes/level_building.tscn")





	


func _on_play_button_pressed() -> void:
	GameManager.start_game()
	queue_free()





func _on_exit_button_pressed() -> void:
	GameManager.exit_game()
