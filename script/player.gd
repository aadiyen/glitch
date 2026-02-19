extends CharacterBody2D
const  GRAVITY = 1000
var bullet = preload("res://scenes/bullet.tscn") # export the bullet
var player_death_effect = preload("res://scenes/player_death_effect.tscn")
var restart_button = preload("res://scenes/restart_button.tscn")
@onready var muzzle: Marker2D = $Muzzle
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var hit_animation_player: AnimationPlayer = $HitAnimationPlayer



@export var speed : int = 300
@export var jump : int = -300
@export var jump_horizontal : int = 200
@export var max_horizontal_speed : int = 300
@export var max_jump_horizontal_speed : int = 300
@export var speed_slowdown : int = 17000
@export var jump_count : int = 1
enum State {Idle , Run , Jump, shoot}  # describe the state of the player lodu

var facing_direction: int = 1 # bug fixing for bullet not launching while being idle lodu
var character_sprite : Sprite2D
var current_state : State    # yes my code breaks sometimes now what to do?? madarchod!!
var muzzle_position 
var current_jump_count

func _ready() :
	current_state = State.Idle
	muzzle_position = muzzle.position
	
	


func _physics_process(delta:float):
	if current_state != State.shoot :
		player_falling(delta)
		player_idle(delta)
		player_run(delta)
		player_jump(delta)
		player_shooting(delta)
		player_muzzle_position()
		move_and_slide()
		player_animation()
		
		
	
	

		
		
	
func player_falling(delta: float):
	if !is_on_floor():
		velocity.y += GRAVITY * delta

func player_idle(delta:float):
	if is_on_floor():
		current_state = State.Idle
		
func player_shooting(delta: float):
	var direction = input_movement()
	if is_on_floor() and Input.is_action_just_pressed("shoot"):
		$AudioStreamPlayer2D.pitch_scale = randf_range(0.95,1.1) # bullet sound pitch
		$AudioStreamPlayer2D.volume_db = randf_range(-10,4)   # bullet sound decible
		$AudioStreamPlayer2D.play()
		var bullet_instance = bullet.instantiate() as Node2D
		bullet_instance.direction = direction
		bullet_instance.direction = facing_direction
		bullet_instance.global_position = muzzle.global_position
		get_parent().add_child(bullet_instance)
		current_state = State.shoot
	
func player_muzzle_position():
	var direction = input_movement()
	if direction > 0:
		muzzle_position.x = muzzle_position.x
	elif direction < 0:
		muzzle_position.x = -muzzle_position.x
	



		

		
		
func player_run(delta:float):
	if !is_on_floor():
		return
	
	var direction = input_movement()
	if direction:
		velocity.x += direction * speed * delta
		velocity.x = clamp(velocity.x, -max_horizontal_speed, max_horizontal_speed)
	else:
		velocity.x = move_toward(velocity.x, 0 ,speed_slowdown * delta )
	if direction != 0:
		facing_direction = direction
		current_state = State.Run
		animated_sprite_2d.flip_h = false if direction > 0 else  true
	
	
func player_jump(delta:float):
	var jump_input : bool  = Input.is_action_just_pressed("jump")
	if is_on_floor() and jump_input:
		current_jump_count = 0
		velocity.y = jump
		current_jump_count += 1
		current_state = State.Jump
		
	if !is_on_floor() and jump_input and current_jump_count < jump_count: # double jump state code
		current_jump_count +=1
		velocity.y = jump
		current_state = State.Jump
		
		
		
	if !is_on_floor() and current_state == State.Jump :
		var direction = input_movement()
		velocity.x += direction * jump_horizontal * delta
		velocity.x = clamp(velocity.x, -max_jump_horizontal_speed, max_jump_horizontal_speed)


		
func player_animation():
	if current_state == State.Idle : #and   animated_sprite_2d.animation != "shoot" :
		animated_sprite_2d.play("idle")
		#print("idle")
	elif current_state == State.Run : #and animated_sprite_2d.animation != "idle":
		animated_sprite_2d.play("run")
		
	elif current_state == State.Jump:
		animated_sprite_2d.play("jump")
		
	elif current_state == State.shoot :
		animated_sprite_2d.play("shoot")
		
		
func player_death():
	var player_death_effect_instance = player_death_effect.instantiate() as Node2D
	player_death_effect_instance.global_position = global_position
	get_parent().add_child(player_death_effect_instance)
	#$"../../AudioStreamPlayer".stop()
	
	queue_free()
	
	
	
	
	
# restart after player death
	var restart_button_instance = restart_button.instantiate()
	get_parent().add_child(restart_button_instance)
	

	
	
	

func input_movement():
	var direction : float = Input.get_axis("move_left","move_right")
	return direction


func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite_2d.animation == "shoot":
		current_state = State.Idle
		
		
		



func _on_hurtbox_body_entered(body: Node2D):
	if body.is_in_group("Enemy"):
		print("body entered:",body.damage_amount)
		hit_animation_player.play("hit")
		HealthManager.decrease_health(1)
	if HealthManager.current_health == 0:
		player_death()
	
		
		



func _on_hurtbox_area_entered(area: Area2D) -> void: # for dyna,mic type enemy damage
	if area.is_in_group("Enemy"):
		hit_animation_player.play("hit")
		HealthManager.decrease_health(1)
	if area.is_in_group("health"):
		HealthManager.increase_health(1)
		HealthManager.increase_health(2)
		HealthManager.increase_health(3)
		
	if HealthManager.current_health == 0:
		player_death()
		print("enemy attack")
	#var cam = get_viewport().get_camera_2d()
	#if cam:
		#cam.start_shake(0.2,9)
