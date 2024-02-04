extends Node3D

class_name Game3D

@onready var engine : GameEngine = get_node_or_null("../../../../")
@onready var game : ActualGame = get_node_or_null("../../../")
@onready var shoe_container : Node3D = $"Shoe Container"
@onready var camera : Camera3D = $Camera3D

@export var offset_spawn = 1

func add_flying_shoe(flying_shoe : FlyingShoe, from : Vector2, to : Vector2, speed):
	var from_3d = camera.project_position(from, camera.near + offset_spawn)
	var to_3d = camera.project_position(to, abs(camera.position.z))
	
	flying_shoe.set_movement(from_3d, to_3d, speed)
	
	shoe_container.add_child(flying_shoe)
