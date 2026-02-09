extends Node2D
@export var award_amount : int = 1
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var label: Label = $Label


func _ready():
	label.hide()
	
	


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print(award_amount)
		
		label.text = "%s" % award_amount # displaye the no of amount while getting in contact
		Collectablemagager.give_pickup_award(award_amount)
		label.show()
	var tween = get_tree().create_tween()
	tween.tween_property(label,"position",Vector2(label.position.x,label.position.y + -10),0.5).from_current # tween the property by 10 pixel
	tween.tween_callback(queue_free) # freely dissapear the collectibles
