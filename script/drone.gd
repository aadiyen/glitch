extends CharacterBody2D
class_name spiderenemy
const speed = 100
var is_drone_chase : bool
var dir : Vector2 = Vector2.LEFT
var player : CharacterBody2D
var damage_to_deal = 20

func _ready() -> void:
	is_drone_chase = true

func _physics_process(delta: float) -> void:
	handle_animation()
	move(delta)
	Global.spiderDamageAmount = damage_to_deal
	Global.spiderDamageZone = $SpiderAttackArea

func handle_animation():
	var animated_sprite2d = $AnimatedSprite2D
	animated_sprite2d.play("walk")
	if dir.x < 0:
		animated_sprite2d.flip_h = true
	elif dir.x > 0:
		animated_sprite2d.flip_h = false

func move(delta):
	if is_drone_chase:
		player = Global.playerbody
		velocity = position.direction_to(player.position) * speed
		if velocity.x != 0:
			dir.x = sign(velocity.x)
	elif !is_drone_chase:
		velocity += dir.x * speed * delta
	move_and_slide()

func _on_timer_timeout() -> void:
	$Timer.wait_time = choose([0.5, 0.8])
	if !is_drone_chase:
		dir = choose([Vector2.UP, Vector2.DOWN, Vector2.LEFT, Vector2.RIGHT])
		print(dir)

func choose(array):
	array.shuffle()
	return array.front()
