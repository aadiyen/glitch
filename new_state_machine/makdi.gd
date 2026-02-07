extends CharacterBody2D

var enemy_death_effect = preload("res://scenes/enemy_death_effect.tscn")

const GRAVITY : int = 1000


@export_group("Movement")
@export var speed : int = 100
@export var chase_speed : int = 150
@export var damage_amount : int = 1



@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var wall_ray: RayCast2D = $WallRay
@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var state_machine: Node = $StateMachine
@onready var attack_collision: CollisionShape2D = $AttackArea/Attack_CollisionShape # to disable the collision initially
@onready var attack_area: Area2D = $AttackArea
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var hurt_collision: CollisionShape2D = $HurtBox/hurt_collision #hurtbox collision





@export_group("PatrolSettings")
@export var patrol_range : int = 200
@export var patrol_left_x : float
@export var patrol_right_x : float

var player : CharacterBody2D = null
var health_amount : int = 5
var is_dead : bool = false


func _ready():
	patrol_left_x = global_position.x - patrol_range
	patrol_right_x = global_position.x + patrol_range

func _physics_process(delta: float):
	if !is_on_floor():
		velocity.y = GRAVITY * delta * speed
	move_and_slide()

func play_anim(anim_name : String):
	if sprite.sprite_frames.has_animation(anim_name):
		sprite.play(anim_name)
		print(anim_name)
		

		
		
	

func set_direction(dir : float):
	if dir == 0 : return
	sprite.flip_h = (dir<0)
	wall_ray.target_position.x = 40 if dir > 0 else -40
	collision_shape.position.x = -5 if dir > 0 else 5
	hurt_collision.position.x =  -5 if dir > 0 else 5

func _on_detection_area_body_entered(body: Node2D) -> void:
	if is_dead: return
	if body.is_in_group("player"):
		player = body
		state_machine.change_state("Chase")
		print("player entered ")
		



func _on_detection_area_body_exited(body: Node2D) -> void:
	if is_dead: return
	if body == player:
		player = null
		state_machine.change_state("Patrol")
		print("body exited")
		
func _on_attack_area_body_entered(body: Node2D) -> void:
	if is_dead: return
	if body.is_in_group("player"):
		state_machine.change_state("Attack")
		print("tatakae")



func _on_hurt_box_area_entered(area: Area2D) -> void:
	if is_dead: return
	if area.get_parent().has_method("get_damage_amount"):
		var node = area.get_parent() as Node2D
		
	# enemy hit shader
		var tween = get_tree().create_tween()
		tween.tween_method(SetShader_BlinkIntensity,1,0,0.5)
	
	# camera shake
		var cam = get_viewport().get_camera_2d()
		if cam:
			cam.start_shake(0.12,7)
		
		# apply damage
		health_amount -= node.damage_amount
		
	if health_amount <= 0:
		die()
		
			
func SetShader_BlinkIntensity(new_Value : float):
	animated_sprite_2d.material.set_shader_parameter("blink_intensity",new_Value)


func die():
	if is_dead: return
	is_dead = true
	velocity = Vector2.ZERO
	
	 # disable state machine
	if state_machine:
		state_machine.set_physics_process(false)
		state_machine.set_process(false)
	
	# spawn death effect
	if enemy_death_effect:
		var effect = enemy_death_effect.instantiate()
		effect.global_position = global_position
		get_parent().add_child(effect)
	
	queue_free()
	
	
	
