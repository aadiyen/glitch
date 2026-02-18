extends Camera2D
@export var player : CharacterBody2D
var shake_time := 0.0
var shake_strength := 0.0
var original_offset = Vector2.ZERO


func _ready():
	original_offset = offset
	
func start_shake(time:=0.15 , strength:=8):
	shake_strength = strength
	shake_time = time
	
func _physics_process(delta):
	if player != null:
		global_position = player.global_position
	
	
	if shake_time > 0:
		shake_time -= delta
		offset = original_offset + Vector2(randf_range(-1,1),randf_range(-1,1)) * shake_strength
		
	else:
		offset = original_offset
	
