extends CharacterBody2D

const  GRAVITY : int = 1000
@export var enemy_death_effect = preload("res://scenes/enemy_explosion_2.tscn")
@export var damage_amount : int = 1

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


enum State {Idle}

var current_state : bool # current state of the enemy



var health_amount : int = 8

func _ready() -> void:
	current_state = State.Idle
	
func _physics_process(delta):
	if !is_on_floor():
		velocity.y += GRAVITY * delta
	idle_state(delta)
	move_and_slide()
	
	
func idle_state(delta):
	current_state = State.Idle
	


		


func _on_hurt_box_area_entered(area: Area2D) -> void: # damage taken by the player bullet
	if area.get_parent().has_method("get_damage_amount"):
		var node = area.get_parent() as Node2D
		
	# hit shaders 
		var tween = get_tree().create_tween()
		tween.tween_method(SetShader_BlinkIntensity,1,0,0.5)
	
		
	# camera shake
		var cam = get_viewport().get_camera_2d()
		if cam:
			cam.start_shake(0.12,7)
		
		
		health_amount -= node.damage_amount
	if health_amount <= 0:
		var enemy_death_effect_instance = enemy_death_effect.instantiate()
		enemy_death_effect_instance.global_position = global_position
		get_parent().add_child(enemy_death_effect_instance)
		queue_free()
		
func SetShader_BlinkIntensity(new_Value : float):
	animated_sprite_2d.material.set_shader_parameter("blink_intensity",new_Value)
		
		
		
		
		
