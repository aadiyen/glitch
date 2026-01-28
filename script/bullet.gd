extends AnimatedSprite2D

var bullet_impact_effect = preload("res://scenes/bulletempact_effect.tscn")
var direction : int
var speed : int =  600
var damage_amount : int = 3
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move_local_x(direction * speed * delta)





func _on_timer_timeout():
	queue_free()




func _on_hitbox_area_entered(area: Area2D) -> void:
	print("bullet area entered")
	bullet_impact()


func _on_hitbox_body_entered(body: Node2D) -> void:
	print("bullet body entered")
	bullet_impact()
	
func get_damage_amount() -> int:
	return damage_amount
	
func bullet_impact():
	var bullet_impact_effect_instance = bullet_impact_effect.instantiate() as Node2D
	bullet_impact_effect_instance.global_position = global_position
	get_parent().add_child(bullet_impact_effect_instance)
	queue_free()
	print("bullet impact hogya")
	
