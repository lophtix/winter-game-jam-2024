extends RigidBody3D

class_name FlyingShoe

@onready var sprite : Sprite3D = $Sprite

var shoe_type : Shoe.ShoeType

var flying : bool

var time_flying_current : float 
var time_flying_max : float

var start_position : Vector3
var end_position : Vector3


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

func _integrate_forces(state : PhysicsDirectBodyState3D):
	if flying:
		#state.transform.origin = lerp(start_position, end_position, time_flying_current/time_flying_max)
		var t = time_flying_current/time_flying_max
		var x = start_position.x * (1 - t) + end_position.x * t
		var z = start_position.z * (1 - t) + end_position.z * t
		var angle_factor = 6
		var y = -angle_factor * t * (t - 1) + end_position.y * t + start_position.y
		state.transform.origin = Vector3(x, y, z)

func set_movement(from : Vector3, to : Vector3, duration : float):
	flying = true
	
	time_flying_current = 0
	time_flying_max = duration
	
	start_position = from
	end_position = to
	
	position = start_position

func set_type(shoe_type : Shoe.ShoeType):
	self.shoe_type = shoe_type


func set_looks(shoe_texture : Texture2D):
	sprite.texture = shoe_texture
