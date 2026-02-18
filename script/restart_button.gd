extends CanvasLayer






func _on_restart_button_pressed() -> void:
	get_tree().reload_current_scene()
	HealthManager.reset_health()
	Collectablemagager.reset_award_amount()
	queue_free()
