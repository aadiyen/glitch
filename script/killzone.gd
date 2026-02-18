extends Area2D

@onready var timer: Timer = $Timer


@onready var player: CharacterBody2D = $"../Player/player"




func _on_body_entered(body):
	if body.is_in_group("player"):
		print("you died!!")
		HealthManager.reset_health()
		Collectablemagager.reset_award_amount()
		timer.start()


func _on_timer_timeout() -> void:
	get_tree().reload_current_scene()
	#player.death()
	queue_free()
	
	

	
	
	
	
