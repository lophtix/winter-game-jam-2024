extends Area3D

class_name GameBox

@export var box_color = Shoe.ShoeType.ORANGE
#@export var box_type = "1"

@export var box_width = 3
@export var box_height = 1.25
@export var box_depth = 2
var box_size: Vector3

@export var lid_width = 3.1
@export var lid_height = 0.5
@export var lid_depth = 2.1
var lid_size: Vector3

@onready var game3d: Game3D

func get_box_color_path():
	match box_color:
		Shoe.ShoeType.ORANGE:
			return "res://assets/orange/Orange"
		Shoe.ShoeType.RED:
			return "res://assets/red/Red"
		Shoe.ShoeType.GREEN:
			return "res://assets/green/Green"
		Shoe.ShoeType.BLUE:
			return "res://assets/blue/Blue"
		Shoe.ShoeType.YELLOW:
			return "res://assets/yellow/Yellow"
		_:
			return "Invalid " + box_color

func set_type(type: Shoe.ShoeType):
	box_color = type
	
		# Set box mesh
	var box_mesh = BoxMesh.new()
	var box_material = StandardMaterial3D.new()
	var box_texture = load(get_box_color_path() + "Box1.png")
	box_material.albedo_texture = box_texture
	box_material.uv1_scale = Vector3(3, 2, 1)
	box_mesh.material = box_material
	box_mesh.size = box_size
	$BoxCollisionShape/MeshInstance3D.mesh = box_mesh
	
		# Set lid mesh
	var lid_mesh = BoxMesh.new()
	var lid_material = StandardMaterial3D.new()
	var lid_texture = load(get_box_color_path() + "Top1.png")
	lid_material.albedo_texture = lid_texture
	lid_material.uv1_scale = Vector3(3, 2, 1)
	lid_mesh.material = lid_material
	lid_mesh.size = lid_size
	$LidCollisionShape/MeshInstance3D.mesh = lid_mesh

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var maybe_game3d = get_node_or_null("../")
	if maybe_game3d is Game3D:
		game3d = maybe_game3d 
	
	# TODO: Ugly, fix later...
	box_size = Vector3(3, 1.25, 2)
	lid_size = Vector3(3.1, 0.5, 2.1)

	# Set box collision shape
	var box_shape = BoxShape3D.new()
	box_shape.set_size(box_size)
	$BoxCollisionShape.shape = box_shape

	# Set lid collision shape
	var lid_shape = BoxShape3D.new()
	lid_shape.set_size(box_size)
	$LidCollisionShape.shape = lid_shape
	
	set_type(box_color)

func handle_new_shoe(shoe_type: Shoe.ShoeType):
	if game3d:
		var score = 30
		if box_color == shoe_type:
			score *= 4
		
		game3d.game.add_score(score)

func _on_body_entered(body):
	if body is FlyingShoe:
		# Save data from shoe
		var shoe_type = body.shoe_type

		body.queue_free()

		handle_new_shoe(shoe_type)
