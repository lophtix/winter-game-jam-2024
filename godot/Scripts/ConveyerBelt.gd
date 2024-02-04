extends Node3D

@onready var score_box_packed : PackedScene = load("res://Scenes/ScoreBox.tscn")  

@onready var conveyor_proximity : Area3D = $"Conveyor Proximity"

var boxes_types : Array[Shoe.ShoeType]
var boxes : Array[RigidBody3D]

@export var spawnStart : Vector3
@export var spawnEnd : Vector3
@export var spawnHeight : float


# Called when the node enters the scene tree for the first time.
func _ready():
	if not boxes_types:
		boxes_types = [
			randi() % Shoe.ShoeType.size(),
			randi() % Shoe.ShoeType.size(),
			randi() % Shoe.ShoeType.size(),
			randi() % Shoe.ShoeType.size(),
			randi() % Shoe.ShoeType.size()
		]
	
	boxes = []
	var spawnHeightStep = 0
	for box in boxes_types:
		var score_box : Node3D = score_box_packed.instantiate()
		var visual_box : VisualBox = score_box.find_child("VisualBox")
		
		visual_box.set_shape(box)
		
		boxes.append(score_box)
		
		for child in score_box.get_children():
			child.scale *= 0.25
		
		score_box.position = lerp(spawnStart, spawnEnd, randf())
		score_box.position.y += spawnHeightStep
		spawnHeightStep += spawnHeight
		
		add_child(score_box)
		
		#score_box.add_constant_force(Vector3(3,0,0))

func _on_conveyor_proximity_area_entered(area):
	update_conveyor_belt()

func _on_conveyor_proximity_area_exited(area):
	update_conveyor_belt()

func update_conveyor_belt():
	for box : RigidBody3D in boxes:
		if conveyor_proximity.overlaps_body(box):
			box.add_constant_force(Vector3(3,0,0))
		else:
			box.add_constant_force(Vector3(0,0,0))
