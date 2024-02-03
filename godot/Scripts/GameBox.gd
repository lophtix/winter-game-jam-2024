extends Area3D

class_name GameBox

@export var box_color = "Orange"
#@export var box_type = "1"

@export var box_width = 3
@export var box_height = 1.25
@export var box_depth = 2

@export var lid_width = 3.1
@export var lid_height = 0.5
@export var lid_depth = 2.1


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    # TODO: Ugly, fix later...
    var box_size = Vector3(3, 1.25, 2)
    var lid_size = Vector3(3.1, 0.5, 2.1)    
    
    # Set box collision shape
    var box_shape = BoxShape3D.new()
    box_shape.set_size(box_size)
    $BoxCollisionShape.shape = box_shape
    
    # Set box mesh
    var box_mesh = BoxMesh.new()
    var box_material = StandardMaterial3D.new()
    var box_texture = load("res://assets/" + box_color.to_lower() + "/" + box_color + "Box1.png")
    box_material.albedo_texture = box_texture
    box_material.uv1_scale = Vector3(3, 2, 1)
    box_mesh.material = box_material
    box_mesh.size = box_size
    $BoxCollisionShape/MeshInstance3D.mesh = box_mesh
    
    # Set lid collision shape
    var lid_shape = BoxShape3D.new()
    lid_shape.set_size(box_size)
    $LidCollisionShape.shape = lid_shape
    
    # Set lid mesh
    var lid_mesh = BoxMesh.new()
    var lid_material = StandardMaterial3D.new()
    var lid_texture = load("res://assets/" + box_color.to_lower() + "/" + box_color + "Top1.png")
    lid_material.albedo_texture = lid_texture
    lid_material.uv1_scale = Vector3(3, 2, 1)
    lid_mesh.material = lid_material
    lid_mesh.size = lid_size
    $LidCollisionShape/MeshInstance3D.mesh = lid_mesh


func handle_new_shoe():
	pass


func _on_body_entered(body):
	if body is FlyingShoe:
		# Save data from shoe
		
		print("Collision detected!")
		
		body.queue_free()
		
		handle_new_shoe()
