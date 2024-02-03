extends Area3D

class_name GameBox


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func handle_new_shoe():
	pass


func _on_body_entered(body):
	if body is FlyingShoe:
		# Save data from shoe
		
		print("Collision detected!")
		
		body.queue_free()
		
		handle_new_shoe()
