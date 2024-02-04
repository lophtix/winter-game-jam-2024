extends Node3D

class_name ConveyorBelt

var score_box_packed : PackedScene = preload("res://Scenes/ScoreBox.tscn")  

@onready var conveyor_proximity : Area3D = $"Conveyor Proximity"

var boxes : Array[RigidBody3D]

@export var spawnStart : Vector3
@export var spawnEnd : Vector3
@export var spawnHeight : float

const speed = 2

func _ready():
	for wheel in $Wheels.get_children():
		wheel.rotation.z -= randf() * PI * 2

func _process(delta):
	for wheel in $Wheels.get_children():
		wheel.rotation.z -= speed * delta

# Called when the node enters the scene tree for the first time.
func add_boxes(boxes_to_add : Array[VisualBox]):
	var spawnHeightStep = 0
	for visual_box in boxes_to_add:
		var score_box : Node3D = score_box_packed.instantiate()
		
		add_child(score_box)
		
		score_box.remove_child(score_box.find_child("VisualBox"))
		score_box.add_child(visual_box.duplicate())
		
		boxes.append(score_box)
		
		for child in score_box.get_children():
			child.scale *= 0.25
		
		score_box.position = lerp(spawnStart, spawnEnd, randf())
		score_box.position.y += spawnHeightStep
		spawnHeightStep += spawnHeight


func add_boxes_from_game(game : ActualGame):
	var game_boxes = game.game3d.get_boxes()
	
	var visual_boxes : Array[VisualBox] = []
	
	for game_box in game_boxes:
		visual_boxes.append(game_box.visual_box)
	
	add_boxes(visual_boxes)


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
