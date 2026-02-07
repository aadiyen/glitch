extends AnimatedSprite2D

var speed : int = 1000

func _ready() -> void:
	position.x = speed 
	
func _physics_process(delta):
	pass
	
	


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		
		
