extends CharacterBody2D

var enemy_death_effect = preload("res://scenes/enemy_death_effect.tscn")
@export var speed : int = 2500
@export var wait_time :int = 1 # these values can help us maniplate the values of speed as well as wait time of enemy manually
@export var patrol_points : Node
@export var damage_amount : int = 2
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var timer: Timer = $Timer # timer for patrolling as i remember what the faaawwkkk



const GRAVITY = 1000
#const SPEED = 2500

enum State {Walk, Idle}
var current_state : State
var direction : Vector2 = Vector2.LEFT
var number_of_points : int
var point_positions : Array[Vector2]
var current_point : Vector2
var current_point_position : int
var can_walk : bool
var health_amount : int = 5

func _ready():
	if patrol_points != null:
		number_of_points = patrol_points.get_children().size()
		for point in patrol_points.get_children():
			point_positions.append(point.global_position)
		current_point = point_positions[current_point_position]
	else:
		print("point not found:")
	current_state = State.Idle
	timer.wait_time = wait_time
	
func _physics_process(delta):
	enemy_gravity(delta)
	enemy_idle(delta)
	enemy_walk(delta)
	move_and_slide()
	enemy_animation()
	
func enemy_gravity(delta):
	velocity.y += GRAVITY * delta
	
func enemy_idle(delta):
	if !can_walk:
		velocity.x = move_toward(velocity.x, 0 ,  speed * delta)
		current_state = State.Idle
	
func enemy_walk(delta):
	if !can_walk:
		return
	
	if abs(position.x -current_point.x) > 0.5:
		velocity.x = direction.x * speed * delta
		current_state = State.Walk
	else:
		current_point_position += 1
		if current_point_position >= number_of_points:
			current_point_position = 0
		current_point = point_positions[current_point_position]
		
		if current_point.x > position.x:
			direction = Vector2.RIGHT
		else:
			direction = Vector2.LEFT
		can_walk = false
		timer.start()
	animated_sprite_2d.flip_h = direction.x < 0
	
func enemy_animation():
	if current_state == State.Idle and !can_walk:
		animated_sprite_2d.play("idle")
	elif current_state == State.Walk and can_walk:
		animated_sprite_2d.play("walk")
	
	


func _on_timer_timeout() -> void:
	can_walk = true
	


func _on_hurtbox_area_entered(area: Area2D):
	if area.get_parent().has_method("get_damage_amount"):
		var node = area.get_parent() as Node
		var tween = get_tree().create_tween() #hit shader tween
		tween.tween_method(SetShader_BlinkIntensity,1,0,0.5) # hit shaders
		
		# camera shake
		var cam = get_viewport().get_camera_2d()
		if cam:
			cam.start_shake(0.12,7)
		
		
		
		health_amount -= node.damage_amount
		#print("Hurtbox area entered")
		print("healt:",health_amount)
		
		if health_amount <= 0:
			var enemy_death_effect_instance = enemy_death_effect.instantiate() as Node2D
			enemy_death_effect_instance.global_position = global_position
			get_parent().add_child(enemy_death_effect_instance)
			queue_free()

func SetShader_BlinkIntensity(newValue : float):
	animated_sprite_2d.material.set_shader_parameter("blink_intensity",newValue)
			
			
