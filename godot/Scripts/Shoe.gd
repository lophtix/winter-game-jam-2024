extends RigidBody2D

class_name Shoe

func _ready():
	pass # Replace with function body.

func _process(_delta):
	if global_position.y > get_viewport_rect().size.y * 1.2:
		queue_free()

func whack():
	print("Whacked")
	queue_free()
