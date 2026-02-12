extends CharacterBody2D

@export var enemy_death_effect = preload("res://scenes/enemy_death_effect.tscn")
@export var enemy_shoot = preload("res://scenes/enemy_bullet.tscn")
@export var shoot_direction = Vector2(-1,0)

const GRAVITY : int = 1000
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var fire_timer: Timer = $FireTimer
@onready var marker_2d: Marker2D = $Marker2D

var player = null
var can_shoot = true
var health_amount : int = 5
var damage_amount : = 1
func _physics_process(delta):
	if !is_on_floor():
		velocity.y += GRAVITY * delta
	move_and_slide()




func _on_detection_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player = body
		fire_timer.start()
		print("body entered attack!!")
		

func _on_detection_area_body_exited(body: Node2D) -> void:
	if body == player:
		player = null
		fire_timer.stop()
		print("timer stopped")


func _on_hurtbox_area_entered(area: Area2D) -> void:
	if get_parent().has_method("get_damage_amount"):
		var node = area.get_parent()  as Node2D
		
		# decrease health
		health_amount -=node.damage_amount
		# hit shaders
		var tween = get_tree().create_tween()
		tween.tween_method(SetShader_BlinkIntensity, 1.0, 0.0, 0.5)
		
		var cam = get_viewport().get_camera_2d()
		if cam:cam.start_shake(0.12,7)
		
	
	var enemy_death_effect_instance = enemy_death_effect.instantiate()
	enemy_death_effect_instance.global_position = global_position
	get_parent().add_child(enemy_death_effect_instance)
	queue_free()
	
	

func _on_fire_timer_timeout():
	if player:
		shoot()

func shoot():
	var enemy_shoot_instance = enemy_shoot.instantiate()
	get_tree().root.add_child(enemy_shoot_instance)
	enemy_shoot_instance.global_position = marker_2d.global_position
	
	#var dir = (player.global_position - global_position ).normalized()
	enemy_shoot_instance.direction = shoot_direction
	$AnimatedSprite2D.play("shoot")
	
func SetShader_BlinkIntensity(new_Value: float):
	animated_sprite_2d.materialset_shader_parameter("blink_intensity", new_Value)
	
