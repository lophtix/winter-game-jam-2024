extends Node3D

class_name Game3D

@onready var engine : GameEngine = get_node_or_null("../../../../")
@onready var game : ActualGame = get_node_or_null("../../../")
@onready var shoe_container : Node3D = $"Shoe Container"
@onready var camera : Camera3D = $Camera3D

@export var offset_spawn = 1

func _ready():
	var shoe_type_values = Shoe.ShoeType.values()
	$Box.set_type(shoe_type_values[randi() % shoe_type_values.size()])
	$Box2.set_type(shoe_type_values[randi() % shoe_type_values.size()])
	$Box3.set_type(shoe_type_values[randi() % shoe_type_values.size()])
	$Box4.set_type(shoe_type_values[randi() % shoe_type_values.size()])
	$Box5.set_type(shoe_type_values[randi() % shoe_type_values.size()])
	$Box6.set_type(shoe_type_values[randi() % shoe_type_values.size()])
	$Box7.set_type(shoe_type_values[randi() % shoe_type_values.size()])
	$Box8.set_type(shoe_type_values[randi() % shoe_type_values.size()])

func add_flying_shoe(flying_shoe : FlyingShoe, from : Vector2, to : Vector2, speed):
	var from_3d = camera.project_position(from, camera.near + offset_spawn)
	var to_3d = camera.project_position(to, abs(camera.position.z))
	
	flying_shoe.set_movement(from_3d, to_3d, speed)
	
	shoe_container.add_child(flying_shoe)
