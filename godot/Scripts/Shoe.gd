extends RigidBody2D

class_name Shoe

@onready var sprite : Sprite2D = $Sprite

@onready var flyingShoePacked : PackedScene = preload("res://Scenes/FlyingShoe.tscn")

func _process(_delta):
	if global_position.y > get_viewport_rect().size.y * 1.2:
		queue_free()
		

func whack(bat_strength : float, bat_vector : Vector2):
	# Spawn 3D shoe and hand it to 3D engine to use
	var flying_shoe = flyingShoePacked.instantiate()
	
	# Calculate target from bat
	var from = Vector2(position.x, position.y)
	var to = from
	
	# Make shoe fly
	flying_shoe.set_movement(from, to)
	
	# Have shoe look like this shoe
	flying_shoe.set_looks(self)
	
	# Hand shoe to 3d engine for it to use
	# engine3d.add_shoe(flying_shoe)
	
	queue_free()

func get_textute():
	return sprite.texture
