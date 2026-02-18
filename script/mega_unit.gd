extends CharacterBody2D

@export var enemy_death_effect = preload("res://scenes/enemy_death_effect.tscn")

const GRAVITY : int = 1000

@export_group("Movement")
@export var speed : int = 500
@export var chase_speed : int = 1000
@export var damage_amount : int = 2

@export_group("PatrolSetting")
@export var patrol_range : int = 200
@export var patrol_left_x : float
@export var patrol_right_x : float

@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var wall_ray: RayCast2D = $wallray
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var state_machine: Node = $StateMachine

var player : CharacterBody2D = null
var health_amount : int = 7
var is_dead : bool = false

func _ready():
	patrol_left_x = global_position.x - patrol_range
	patrol_right_x = global_position.x + patrol_range

func _physics_process(delta):
	if is_dead: return # Optimization: stop physics if dead
	if !is_on_floor():
		velocity.y += GRAVITY * delta
	move_and_slide()

func play_anim(anim_name : String):
	if sprite.sprite_frames.has_animation(anim_name):
		sprite.play(anim_name)
		
func set_direction(dir : float):
	if dir == 0 or is_dead: return
	sprite.flip_h = (dir < 0)
	wall_ray.target_position.x = 40 if dir > 0 else -40
	collision_shape.position.x = -5 if dir > 0 else 5

func _on_detection_area_body_entered(body: Node2D) -> void:
	if is_dead: return
	if body.is_in_group("player"):
		player = body
		state_machine.change_state("Chase")

func _on_detection_area_body_exited(body: Node2D) -> void:
	if is_dead: return
	if body == player:
		player = null
		state_machine.change_state("Patrol")

func _on_hurt_box_area_entered(area: Area2D) -> void:
	if is_dead: return
	
	if area.get_parent().has_method("get_damage_amount"):
		var node = area.get_parent()
		
		# Apply damage
		health_amount -= node.damage_amount
		
		# Visual effects
		var tween = get_tree().create_tween()
		tween.tween_method(SetShader_BlinkIntensity, 1.0, 0.0, 0.5)

		var cam = get_viewport().get_camera_2d()
		if cam: cam.start_shake(0.12, 7)
		
		# Check for death
		if health_amount <= 0:
			die()

func SetShader_BlinkIntensity(new_Value: float):
	animated_sprite_2d.material.set_shader_parameter("blink_intensity", new_Value)

func die():
	if is_dead: return
	
	is_dead = true # Set this immediately
	velocity = Vector2.ZERO
	
	# Stop the State Machine logic completely behencho it was tuff!!
	if state_machine:
		state_machine.set_physics_process(false)
		state_machine.set_process(false)
	
	# Spawn death effect
	if enemy_death_effect:
		var effect = enemy_death_effect.instantiate()
		effect.global_position = global_position
		get_parent().add_child(effect)
	
	# Remove the enemy from the game
	queue_free()
