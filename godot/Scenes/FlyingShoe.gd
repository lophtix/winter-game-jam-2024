extends RigidBody3D

class_name FlyingShoe

@onready var sprite : Sprite3D = $Sprite3D

var flying : bool

var time_flying_current : float 
var time_flying_max : float

var start_position : Vector2
var end_position : Vector2

const z_offset : float = 5


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if flying:
		time_flying_current += delta
		
		if time_flying_current >= time_flying_max:
			time_flying_current = time_flying_max
			flying = false
		
		lerp(start_position, end_position, time_flying_current/time_flying_max)

func set_movement(from : Vector2, to : Vector2, duration : float):
	flying = true
	
	time_flying_current = 0
	time_flying_max = duration
	
	start_position = from
	end_position = to

func set_looks(shoe_texture : Texture2D):
	sprite.texture = shoe_texture
