extends CharacterBody2D

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


func _ready():
	patrol_left_x = global_position.x - patrol_range
	patrol_right_x = global_position.x + patrol_range


func _physics_process(delta):
	if !is_on_floor():
		velocity.y += GRAVITY * delta
	move_and_slide()

func play_anim(anim_name : String):
	if sprite.sprite_frames.has_animation(anim_name):
		sprite.play()
		
func set_direction(dir : float):
	if dir == 0 : return
	sprite.flip_h = (dir<0)
	wall_ray.target_position.x = 40 if dir > 0 else -40
	collision_shape.position.x = -5 if dir > 0 else 5
	



func _on_detection_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player = body
		state_machine.change_state("Chase")
		print("player entered the area")
	else:
		print("state not found!!")
		

		
		


func _on_detection_area_body_exited(body: Node2D) -> void:
	if body == player:
		player = null
		state_machine.change_state("Patrol")
	print("body exited")
	
	
