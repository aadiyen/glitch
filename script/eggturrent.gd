extends CharacterBody2D

@export var enemy_shoot = preload("res://scenes/enemy_bullet.tscn")


const GRAVITY : int = 1000

@onready var fire_timer: Timer = $FireTimer
@onready var marker_2d: Marker2D = $Marker2D

var player = null
var can_shoot = true
func _physics_process(delta):
	if !is_on_floor():
		velocity.y += GRAVITY
	move_and_slide()




func _on_detection_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body = player
		fire_timer.start()
		print("body entered attack!!")
		

		
		
		


func _on_detection_area_body_exited(body: Node2D) -> void:
	if body == player:
		player = null
		fire_timer.stop()
		print("timer stopped")


func shoot():
	var enemy_shoot_instance = enemy_shoot.instantiate()
	enemy_shoot_instance.global_position = marker_2d.global_position
	get_parent().add_child(enemy_shoot_instance)
	
	
	
	
	
	
