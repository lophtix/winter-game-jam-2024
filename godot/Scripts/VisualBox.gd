extends Area3D

class_name VisualBox

func get_box_color_path(box_color : Shoe.ShoeType):
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
			return "Invalid " + str(box_color)


# Called when the node enters the scene tree for the first time.
func set_shape(box_color : Shoe.ShoeType):
	var box_size = Vector3(3, 1.25, 2)
	var lid_size = Vector3(3.1, 0.5, 2.1)
	
	var box_variation = randi() % 3 + 1
	
	match box_variation:
		1:
			box_size = Vector3(3, 1.25, 2)
		2:
			box_size = Vector3(2.9, 1.6, 2)
		3:
			box_size = Vector3(2.75, 1.75, 2)
	
	
	# Set box collision shape
	var box_shape = BoxShape3D.new()
	box_shape.set_size(box_size)
	$BoxCollisionShape.shape = box_shape
	$BoxCollisionShape.position.y = box_size.y / 2

	# Set box mesh
	var box_mesh = BoxMesh.new()
	var box_material = StandardMaterial3D.new()
	var box_texture = load(get_box_color_path(box_color) + "Box" + str(box_variation) + ".png")
	box_material.albedo_texture = box_texture
	box_material.uv1_scale = Vector3(3, 2, 1)
	box_mesh.material = box_material
	box_mesh.size = box_size
	$BoxCollisionShape/MeshInstance3D.mesh = box_mesh

	# Set lid collision shape
	var lid_shape = BoxShape3D.new()
	lid_shape.set_size(box_size)
	$LidCollisionShape.shape = lid_shape
	var lid_y_offset = box_size.y / 2
	$LidCollisionShape.position.y = box_size.y

	# Set lid mesh
	var lid_mesh = BoxMesh.new()
	var lid_material = StandardMaterial3D.new()
	var lid_texture = load(get_box_color_path(box_color) + "Top" + str(box_variation) + ".png")
	lid_material.albedo_texture = lid_texture
	lid_material.uv1_scale = Vector3(3, 2, 1)
	lid_mesh.material = lid_material
	lid_mesh.size = lid_size
	$LidCollisionShape/MeshInstance3D.mesh = lid_mesh

func set_box_open(open : bool):
	$LidCollisionShape.visible = not open


