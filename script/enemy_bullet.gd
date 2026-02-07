extends AnimatedSprite2D

@export var speed : int = 100
@export var direction = Vector2.ZERO

func _physics_process(delta):
	position += direction * speed * delta
	



func _on_area_2d_body_entered(body: Node2D) -> void: # body signal trigger for  player
	if body.is_in_group("player"):
		body.take_damage(10)
		queue_free()
	elif  body is TileMapLayer:
		queue_free()
