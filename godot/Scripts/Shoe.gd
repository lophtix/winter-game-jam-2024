extends RigidBody2D

class_name Shoe

@export var shoe_type : ShoeType = ShoeType.BLUE
enum ShoeType { BLUE, GREEN, ORANGE, RED, YELLOW }

@onready var sprite : Sprite2D = $Sprite
@onready var flyingShoePacked : PackedScene = preload("res://Scenes/FlyingShoe.tscn")

@onready var actual_game : ActualGame = $"../../../"

var game: Game

func _process(_delta):
	if global_position.y > get_viewport_rect().size.y * 1.05:
		actual_game.dropped_shoes += 1
		actual_game.update_score()
		queue_free()

func whack(bat_strength : float, _bat_vector : Vector2):
	# Spawn 3D shoe and hand it to 3D engine to use
	var flying_shoe : FlyingShoe = flyingShoePacked.instantiate()
	
	# Calculate target from bat
	var from = Vector2(position.x, position.y)
	var to = from + 0.5 * Vector2(linear_velocity.x, 0)
	
	flying_shoe.rotation.z = -rotation
	flying_shoe.angular_velocity.z = -angular_velocity
	
	# Hand shoe to 3d engine for it to use
	game.game3d.add_flying_shoe(flying_shoe, from, to, bat_strength)
	
	# Have shoe look like this shoe and have the same type
	flying_shoe.set_looks(sprite.texture)
	flying_shoe.shoe_type = shoe_type

	queue_free()

